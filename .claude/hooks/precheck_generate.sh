#!/usr/bin/env bash
# PreToolUse hook สำหรับ mcp__fotal_mcp__generate_shot_video
# หาบ็อกจาก shot_id ใน BOX_MAP → รัน check_prompt.sh กับไฟล์พรอมป์ของบ็อกนั้น
# บล็อกการยิง (exit 2) ถ้ายังเจอ A1 สั่งอวัยวะ · A8 ประโยคปฏิเสธ · A13 กำกับเสียง
# ที่ไม่ได้จดยกเว้นไว้ใน CHANGE LOG ด้วยบรรทัด  "- ด่านยกเว้น: A1 …เหตุผล…"
# ที่มา: user 2026-10-23 "ทำ hook เลย" หลัง SB02-25 ยิงทั้งที่ A1 ขึ้น (กรามเกร็ง → ปากแปลก)

ROOT="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
SKILL="$ROOT/.claude/skills/sd_gen_video"
INPUT=$(cat)
SHOT=$(printf '%s' "$INPUT" | python3 -I -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("shot_id",""))' 2>/dev/null)

if [ -z "$SHOT" ]; then
  echo "precheck: อ่าน shot_id ไม่ได้ — บล็อกไว้ก่อน" >&2; exit 2
fi

# แถวสุดท้ายใน BOX_MAP ที่มี shot_id นี้ = เทคล่าสุดของบ็อก
SB=$(grep -F "$SHOT" "$SKILL/BOX_MAP.md" | tail -1 | sed -E 's/^\| *`([^`]+)`.*/\1/')
if [ -z "$SB" ]; then
  echo "precheck: shot $SHOT ไม่มีใน BOX_MAP.md — เติมแถวบ็อกก่อนยิง" >&2; exit 2
fi

FILE=$(ls "$ROOT"/EP*/"${SB}_prompt.md" 2>/dev/null | head -1)
if [ -z "$FILE" ]; then
  echo "precheck: ไม่เจอไฟล์พรอมป์ ${SB}_prompt.md — บล็อกไว้ก่อน" >&2; exit 2
fi

OUT=$(bash "$SKILL/check_prompt.sh" "$FILE" 2>&1)
BLOCK=""
for code in A1 A8 A13; do
  if printf '%s\n' "$OUT" | grep -q "^── $code "; then
    if ! grep -qE "^- ด่านยกเว้น:.*\b$code\b" "$FILE"; then
      BLOCK="$BLOCK $code"
    fi
  fi
done

if [ -n "$BLOCK" ]; then
  {
    echo "precheck: บล็อกการยิง $SB — ด่านยังขึ้น:$BLOCK (ไฟล์ $FILE)"
    printf '%s\n' "$OUT" | awk -v codes="$BLOCK" '
      /^── /{show=0; n=split(codes,c," "); for(i=1;i<=n;i++) if(index($0,"── " c[i] " ")==1) show=1}
      show' | cut -c1-200
    echo "แก้บรรทัดเหล่านั้น หรือถ้าตั้งใจคงไว้ ให้เติมใน CHANGE LOG: - ด่านยกเว้น: <รหัส> <เหตุผลที่ user สั่ง>"
  } >&2
  exit 2
fi
exit 0

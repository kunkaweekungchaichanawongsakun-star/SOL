#!/bin/bash
# ตรวจพรอมป์ก่อนยิง — รันทุกครั้ง ไม่มีข้อยกเว้น
# ใช้: bash check_prompt.sh EP04/SB04-3_prompt.md
F="$1"
[ -f "$F" ] || { echo "ไม่เจอไฟล์: $F"; exit 1; }
BODY=$(sed -n '1,/^---$/p' "$F")
hit=0

flag () { # flag "ชื่อข้อ" "regex" ["regex ข้อยกเว้น"]
  out=$(printf '%s' "$BODY" | grep -n -iE "$2")
  [ -n "$3" ] && out=$(printf '%s' "$out" | grep -ivE "$3")
  out=$(printf '%s' "$out" | cut -c1-160)
  if [ -n "$out" ]; then hit=1; echo "── $1"; echo "$out"; echo; fi
}

echo "=== ตรวจ $F ==="
flag "A8 ประโยคปฏิเสธ (เอ่ยชื่อของที่ไม่อยากได้)" '\b(never|is not|are not|does not|do not|no [a-z]|nothing|nobody|without)\b'
flag "A1 สั่งอวัยวะ" '\b(her eyes|his eyes|eyebrow|her brow|his brow|her lips|his lips|her chin|his chin|eyelid|jaw)\b' '(height|level|line) of (his|her) eyes|(his|her) eye (line|level)'
flag "A4 กำหนดสายตา" '\b(looks? (at|toward|up|down|away)|gaze|glances?|eyes (lift|drift|go))\b'
CAPS=$(printf "%s" "$BODY" | grep -n -E "\b(EXCITED|ANGRY|SHY|HAPPY|SAD|STARTLED|POUTY|AMUSED|NERVOUS|SMUG|EMBARRASSED|SHEEPISH|PLEASED)\b" | cut -c1-160); if [ -n "$CAPS" ]; then hit=1; echo "── 0.1b ตัวใหญ่กับคำอารมณ์"; echo "$CAPS"; echo; fi
flag "0.1 หมวดล็อก" '^(LOCKS|RULES|CONSTRAINTS)'
flag "สำนวน/คำคลุมเครือ" '\b(as if|as though|the way you|the kind of|sort of|somehow|a touch of)\b'
flag "A13 กำกับเสียง (ดัง-เบา-เร็ว-ช้า-น้ำเสียง) — ไดรเวอร์คุมอยู่แล้ว ห้ามเขียน" '\b(louder|quieter|whispers?|shouts?|hushed|flatly|teasingly|dryly|deadpan|drawls?|breathy|sharply)\b|raises? (her|his) voice|under (her|his) breath|trails? off|raising it|voice rising|speaks? (faster|slower|more quickly)|says? it (faster|slower)|picks? up (the )?pace|speeds? up|slows? it down|drags? the word|lingers? on the word'
flag "A22 ท่ารายอวัยวะ/ท่ารายคำ/ท่าโชว์จากสตอรี่บอร์ด ห้ามยกมา — เขียนว่ารู้สึกอะไร เพราะอะไร และเติมความสมเหตุสมผล (user 2026-10-21)" '^ *- *At "|as if presenting|brows? (draw|knit|furrow)|(little|small) bounce|opens? (her|his) arms'
flag "A20 สั่งคอมโพส/ตำแหน่งในเฟรม — บอกว่าตัวละครทำอะไร ใช้ของอะไร แล้วให้ SD จัดคอมโพสเอง" '\b(frame left|frame right|left of the frame|right of the frame|at frame|(near|bottom|top) edge of the frame|edge of the frame|bottom of the frame|top of the frame|out of the frame|in the near ground|near ground|foreground|cent(re|er) of (the )?frame|fills? (most of )?the (whole )?frame|fills? the (bottom|top|near edge)|runs? along the bottom|past the bottom of)\b|camera (is |stands )?(tipped|angled|tilted|pointed)|tipped (only )?slightly (down|up)|framed from'

REFW='jacket|dress|shirt|tee|blouse|skirt|trousers|jeans|belt|buckle|tights|stockings|heels|shoes|boots|sneakers|handbag|purse|sleeves|hem|collar|cuffs|helmet|fringe|eyebrows|lips|nose|jaw|complexion|teardrop tank|leather seat|wheels|spokes|headlamp|handlebar|exhaust|engine cases|fenders'
REFOUT=$(printf '%s' "$BODY" | grep -nE '^@Image[0-9]' | while IFS= read -r l; do
  n=$(printf '%s' "$l" | grep -ioE "$REFW" | sort -u | wc -l)
  [ "$n" -ge 3 ] && printf '%s\n' "  [$n ชิ้น] $(printf '%s' "$l" | cut -c1-150)"
done)
if [ -n "$REFOUT" ]; then hit=1; echo "── A14 บรรยายของที่รูปเรฟถืออยู่แล้ว — เรฟชนะตัวหนังสือเสมอ ตัดออก เหลือแค่บอกว่าใบไหนถืออะไร"; echo "$REFOUT"; echo; fi

FRAMEOUT=$(printf '%s' "$BODY" | grep -nE '^@Image[0-9]' | grep -iE 'framed (from|at)|cropped (at|from)|photographed against|shot from|taken from the|cut off at' | cut -c1-150)
if [ -n "$FRAMEOUT" ]; then echo "⚠️ A15 อ้างการจัดเฟรมของรูปเรฟ — เปิดรูปดูด้วยตายืนยันก่อน ห้ามเขียนจากที่นึกเอง"; echo "$FRAMEOUT"; echo; fi

## A16 — บรรทัดเรฟที่เอ่ยชื่อคน ต้องตรงกับทะเบียน REF_LINES.md ทุกตัวอักษร
REGISTRY="$(dirname "$0")/REF_LINES.md"
if [ -f "$REGISTRY" ]; then
  # ดึงบรรทัดที่ล็อกไว้ออกจากบล็อก ``` ในทะเบียน (เฉพาะที่อยู่ใต้หัวข้อ "ล็อกแล้ว")
  sed -n '/^## ล็อกแล้ว/,/^## รอ user เคาะ/p' "$REGISTRY" | grep -E '^[A-Z][A-Z ]*:' > /tmp/_reflines.$$ 2>/dev/null
  A16=$(printf '%s' "$BODY" | grep -nE '^@Image[0-9].* — [A-Z][A-Z ]*:' | while IFS= read -r l; do
    num=${l%%:*}
    txt=$(printf '%s' "$l" | sed -e 's/^[0-9]*://' -e 's/@Image[0-9][0-9]*/@ImageN/g')
    body=${txt#* — }
    if ! grep -Fxq "$body" /tmp/_reflines.$$ 2>/dev/null; then
      printf '%s\n' "  $num: $(printf '%s' "$body" | cut -c1-130)"
    fi
  done)
  rm -f /tmp/_reflines.$$
  if [ -n "$A16" ]; then
    hit=1
    echo "── A16 บรรทัดเรฟตัวละครไม่ตรงทะเบียน REF_LINES.md — ห้ามแต่งเอง ถ้าเป็นตัวละครใหม่ ให้ user เคาะบรรทัดก่อน"
    echo "$A16"; echo
  fi
fi

## A17 — ทุกแท็กจีนต้องมีที่มาในตาราง (บท / คำ user / Gemini / สกิล)
if [ -f "$(dirname "$0")/check_tags.pl" ]; then
  A17=$(perl "$(dirname "$0")/check_tags.pl" "$F" 2>&1)
  if [ -n "$A17" ]; then hit=1; echo "$A17"; fi
fi

## A19 — ห้ามบรรยาย "ท่าของเสื้อผ้า" ถ้า user ไม่ได้สั่ง (user สั่ง 2026-09-15)
# ที่มา: SB05-1 เขียน "Her skirt and her hair settle after each move" ไม่มีใครสั่ง → กระโปรงบานตลก
# จับเฉพาะ: เครื่องแต่งกาย + คำเคลื่อนไหว (พลิ้ว แกว่ง บาน ปลิว)
# ⚠️ บอกว่าใส่อะไร/สะพายอะไร เขียนได้ปกติ — user: "ไม่ได้บอกว่าไม่ต้องบอกว่าใส่กระโปรง"
#    รอบแรกผมให้จับ "her + ชื่อเสื้อผ้า" ด้วย กระเป๋าเลยหายจากพร้อมท์ แล้วหายจากคลิป — ถอดทิ้งแล้ว
# ยกเว้นได้เฉพาะคำที่อยู่ในตาราง "## เสื้อผ้าที่ user สั่งให้เอ่ย" ท้ายไฟล์ พร้อมที่มา
WEAR='skirts?|dress(es)?|hem|hemline|pleats?|jacket|coat|blazer|cardigan|sweater|blouse|shirt|tee|trousers|pants|jeans|shorts|stockings|tights|boots|shoes|sneakers|belt|scarf|collar|cuffs?|sleeves?|bag|handbag|purse|strap|necklace|earrings?|hat|outfit|clothes|clothing'
MOVE='settles?|settling|flutters?|fluttering|swings?|swinging|sways?|swaying|flows?|flowing|billows?|billowing|flares?|flaring|lifts?|ripples?|rippling|twirls?|bounces?|bouncing|floats?|floating'
ALLOW=$(sed -n '/^## เสื้อผ้าที่ user สั่งให้เอ่ย/,/^## /p' "$F" | grep -oE '^\| *`[^`]+`' | sed -E 's/^\| *`//; s/`$//')
A19=$(printf '%s' "$BODY" | grep -v '^@Image' | grep -niE "\b($WEAR)\b.{0,40}\b($MOVE)\b")
if [ -n "$ALLOW" ] && [ -n "$A19" ]; then
  while IFS= read -r a; do [ -n "$a" ] && A19=$(printf '%s\n' "$A19" | grep -viF "$a"); done <<< "$ALLOW"
fi
if [ -n "$A19" ]; then
  hit=1
  echo "── A19 บรรยายท่าของเสื้อผ้า (พลิ้ว แกว่ง บาน ปลิว) ที่ user ไม่ได้สั่ง — ลบท่านั้นทิ้ง · การบอกว่าใส่/สะพายอะไร ไม่ผิด · ถ้า user สั่งท่าจริง ให้ใส่ตาราง '## เสื้อผ้าที่ user สั่งให้เอ่ย' พร้อมที่มา"
  printf '%s\n' "$A19" | cut -c1-160; echo
fi

## A18 — ไฟล์ต้องระบุว่าก๊อปมาจากบ็อกไหน (ห้ามเขียนจากศูนย์)
if ! grep -qE 'ก๊อปจาก `SB[0-9]+-[0-9A-Za-z]+_prompt\.md`|^base: `SB|^base: grandfathered' "$F"; then
  hit=1
  echo "── A18 ไม่ได้ระบุว่าก๊อปจากไฟล์ไหน — บ็อกใหม่ต้อง cp จากบ็อกล่าสุดที่ผ่านแล้วแก้ทับ แล้วเขียนใน CHANGE LOG ว่า ก๊อปจาก \`SBxx-x_prompt.md\`"
  echo
fi

## A21 — ต้องมีหมวด BEFORE THIS VIDEO ทุกบ็อก (user สั่ง 2026-10-01)
if ! printf "%s" "$BODY" | grep -q '^BEFORE THIS VIDEO$'; then
  hit=1
  echo "── A21 ไม่มีหมวด BEFORE THIS VIDEO — เล่าสองสามประโยคว่าก่อนเฟรมแรกเกิดอะไรขึ้นแล้ว ขึ้นต้นด้วย All of this has already happened before the first frame."
  echo
fi

## บ็อกนี้คือบ็อกไหน — พิมพ์ให้เห็นก่อนยิง กันยิงผิดบ็อก
MAP="$(dirname "$0")/BOX_MAP.md"
SB=$(basename "$F" | sed 's/_prompt\.md$//')
if [ -f "$MAP" ]; then
  row=$(grep -E "^\| *\`$SB\`" "$MAP" | head -1)
  if [ -n "$row" ]; then echo "=== บ็อกนี้ ==="; echo "$row" | sed 's/^| *//; s/ *| */  ·  /g; s/  ·  $//'; echo
  else echo "⚠️ $SB ไม่มีใน BOX_MAP.md — เติมก่อนยิง"; echo; fi
fi

## A23 — ทุกบีตใน Picture ต้องขึ้นต้นด้วยเวลา (user 2026-10-21 "ปกติถ้าผมกำกับ promtp เอง ผมจะระบุวินาทีการกระทำไว้ เพื่อกันมันสุ่ม")
A23=$(printf '%s\n' "$BODY" | awk '/^SHOT-BY-SHOT/{s=1} /^(THE LAST FRAME|DIALOGUE)/{s=0} s&&/^Picture:/{p=1;next} s&&/^(Camera|Composition|Light|Sound|Shot [0-9]|Cut|What the audience|Meaning|Performance):?/{p=0} s&&p&&/^- /&&!/^- [0-9]/{print NR": "$0}' | cut -c1-140)
if [ -n "$A23" ]; then hit=1; echo "── A23 บีตไม่มีเวลากำกับ — ใส่ วินาทีเริ่ม–จบ ทุกบีต ไม่งั้น SD สุ่มจังหวะเอง (SB02-34 เทค 3 อลิซพูดก่อนเปิดประตู)"; echo "$A23"; echo; fi

echo "=== ช่องเวลาที่ไม่มีใครทำอะไร (A11) — ไล่เองด้วยตา ==="
printf '%s' "$BODY" | grep -nE '^(Shot|From [0-9]|At [0-9])' | cut -c1-120

[ $hit -eq 0 ] && echo "=== ผ่าน ไม่เจอรูปแบบต้องห้าม ===" || echo "=== เจอของที่ต้องแก้ข้างบน ==="

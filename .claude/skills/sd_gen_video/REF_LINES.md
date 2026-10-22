# ทะเบียนบรรทัดเรฟตัวละคร

**บรรทัดที่เอ่ยชื่อคนในบล็อก `ACTIVE REFERENCES` ต้องตรงกับทะเบียนนี้ทุกตัวอักษร**
`check_prompt.sh` ข้อ **A16** เทียบให้อัตโนมัติ — ไม่ตรง = ยิงไม่ได้

**ทำไมถึงมีไฟล์นี้** — ไล่ทั้งโปรเจกต์แล้วพบว่าบรรทัดเรฟของอลิซกับวินเคยเขียนไปแล้ว **23 แบบ** ทั้งที่ควรมีแบบเดียว · หลายแบบมีคำบรรยายชุดยาวเป็นบรรทัด ซึ่งเป็นของที่รูปเรฟถืออยู่แล้ว · และ 10 ก.ย. 2026 ผมเขียน `JACK: 28, tall and slim` ขึ้นมาเองโดยไม่มีที่มา แล้วแจ็คออกมาเป็นคนละคน
กฎอย่างเดียวไม่พอ เพราะกฎแปลว่ายังมีที่ว่างให้เขียน · ทะเบียนแปลว่าไม่เหลือที่ว่าง

## วิธีเทียบ
เครื่องตรวจแปลง `@Image1` `@Image2` ... เป็น `@ImageN` ทั้งหมดก่อน แล้วเทียบตัวอักษรต่อตัวอักษร
จำนวนใบเรฟเปลี่ยนได้ (2 ใบหรือ 3 ใบ) แต่**ข้อความหลังขีดต้องตรงเป๊ะ**

## ตัวละครใหม่
ห้ามเขียนเอง — เสนอบรรทัดในแชตให้ user เคาะก่อน แล้วค่อยเติมลงไฟล์นี้

---

## ล็อกแล้ว

### ALIZ
```
ALIZ: 26, pretty, long straight jet-black hair. 100% matches the reference, and @ImageN is the authority for what she is wearing today.
```
รูปแบบของ EP04-06 · user สั่งให้กลับมาใช้แบบนี้ 2026-09-09 หลังจากผมเปลี่ยนเองตอนขึ้น EP07 โดยไม่มีเหตุผลและไม่ได้บอก
**คาแร็กเตอร์ประจำ: ยิ้มไม่เห็นฟัน** (user 2026-10-15) — ไม่อยู่ในบรรทัดเรฟ ใส่ใน PERFORMANCE ทุกบ็อก: `Aliz's smiles stay small and closed-lip.` (ดู SKILL.md ขั้น 6 การแสดง)

### WIN
```
WIN: 45, thick black swept-back hair with a light scatter of grey at the temples. 100% matches the reference, and @ImageN is the authority for what he is wearing today.
```
**WIN = วิน** — เดิมบรรทัดนี้ชื่อ SING (user ยืนยัน 2026-10-12 *"วิน ชื่อเดิม คือ SING"*) · user สั่ง 2026-10-13 *"เปลี่ยน SING เป็น WIN ให้หมด"* · ในพรอมป์เรียกเขาว่า Win ทุกบรรทัด

### JACK
```
JACK: 28. 100% matches the reference, and @ImageN is the authority for what he is wearing today.
```
user เคาะ 2026-09-10 · ส่ง **2 ใบ** — `jack_face_v3` หน้า · `jack_sheet_v3` ชุด (หน้าตรง + หันหลัง)
อายุ 28 มาจาก `PROJECT.md` บรรทัด 119 · **ไม่มีคำบรรยายรูปร่างเลย** เพราะไม่มีแหล่งที่มา
ที่เคยเขียนผิด: `JACK: 28, tall and slim.` — `tall and slim` แต่งเอง แจ็คออกมาเป็นคนละคน


### NUCH
```
NUCH: 60s, the chairman's secretary. 100% matches the reference, and @ImageN is the authority for what she is wearing today.
```
user เคาะ 2026-09-28 · ส่ง **2 ใบ** — `nuch_face` หน้า · `nuch_sheet` ชุด (หน้าตรง + หันหลัง) แบบเดียวกับแจ็ค
อายุ 60s มาจาก `PROJECT.md` (เลขาวิน · 60 ต้นๆ) · **ไม่มีคำบรรยายรูปร่างเลย** — user ถามว่าต้องใส่ส่วนสูง 157 cm มั้ย ตอบว่าไม่ เพราะโมเดลภาพไม่มีอะไรให้เทียบสเกล และรูปเรฟถือสัดส่วนอยู่แล้ว

### PA JUANG
```
PA JUANG: a Thai woman in her fifties, the housekeeper of the building. THIS REFERENCE CARRIES HER FACE AND HER CLOTHES. It is photographed as a set of studio turnaround views against a plain grey sweep, so where she is and what she is doing come from this video instead. 100% matches the reference for her.
```
VA `pa_juang` (`5RBwcWFB89aiOxcA`) · ป้าแม่บ้าน EP1 · user เคาะ 2026-10-02 (SB08-9) *"ใส่ผ้ากันเปื้อนตามเรฟ"* — ชุดให้เรฟเป็นตัวกำหนด ไม่เขียนบรรยายชุด
---

### MAKEUP ARTIST (ST-01)
```
MAKEUP ARTIST: 30s, head of the styling team. 100% matches the reference for her face and her clothes.
```
user เคาะ 2026-10-23 (สั่ง "ยิง" SB02-46 หลังเสนอบรรทัดนี้) · Mix Stage `ST 01 · หัวหน้าทีมแต่งตัว` `7ff7594f` · ใบเดียวมีทั้งหน้าและชุด

### WARDROBE ASSISTANT (ST-02)
```
WARDROBE ASSISTANT: 20s, the styling team's assistant. 100% matches the reference for her face and her clothes.
```
user เคาะ 2026-10-23 (สั่ง "ยิง" SB02-46 หลังเสนอบรรทัดนี้) · Mix Stage `ST 02 · ผู้ช่วยแต่งตัว` `873cb52b` · ใบเดียวมีทั้งหน้าและชุด

## รอ user เคาะ

(ว่าง)

---

## ของที่ไม่ใช่คน — ไม่อยู่ในทะเบียนนี้
ฉาก · พื้นหลัง · ไดรเวอร์ เขียนตามงานของแต่ละบ็อกได้ เพราะมันเปลี่ยนจริงทุกบ็อก
แต่ยังอยู่ใต้กฎเดิม: **บอกแค่ว่าใบนี้เป็นเจ้าของอะไร ห้ามไล่ว่าในรูปมีอะไร**

รถมอเตอร์ไซค์ใช้รูปนี้:
```
THE MOTORCYCLE. THIS REFERENCE IS THE AUTHORITY FOR THE MACHINE ITSELF.
```
ที่เคยเขียนผิด: ไล่ยี่ห้อถัง เบาะ ล้อ กระจก ยาว 5 บรรทัด — 4 แบบไม่ซ้ำกัน

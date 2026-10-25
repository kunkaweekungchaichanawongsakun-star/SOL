Keep this video as it is: the same lobby, the same camera position and framing, the same two people, the same timing and the same actions from start to end.
The one difference is the car. On Jack's white Mercedes outside the glass, the door standing open is the FRONT PASSENGER DOOR, the front door right beside the side mirror, with the interior light on. The rear door is shut for the whole video.

---

## งาน
- ซ่อมคัท 3 ของ SB02-48 V1 (C2-4 clip11 v2 · 6.04–12.06 วิ) ด้วย Seedance Edit (`transform_video` mode=edit) — user 2026-10-25 *"แก้ C2-4_clip11_v2_SB02-25 คัท 3 เรื่องประตูรถที่เปิดคาไว้ต้องเป็นประตูคนนั่งข้างคนขับ ไม่ใช่ประตูหลัง โดยส่งคลิปคัท 3 ให้ SD แล้ว บอกให้แก้เฉพาะประตูรถ ได้มั้ย?"*
- ต้นทาง: ตัดจาก asset `6ed25ecd` ช่วง 6.042–12.062 → `cut3.mp4` 6.02 วิ 1280×720 (สแครชแพด) · อัปเป็น asset `ed030c43-fe0f-4146-a55b-552b93042111`
- ข้อจำกัดของ Edit: รับวิดีโอต้นทางได้ไฟล์เดียว แนบรูปเรฟประตูหน้า (`75ace63b`) ไม่ได้ · ไม่มีมาสก์ SD สร้างคลิปใหม่ทั้งคลิปตามพรอมป์ ของอื่นอาจขยับเล็กน้อย · ผลออกเป็น asset ใน workspace ไม่ขึ้นเป็นเทคในบ็อก
- พรอมป์เขียนเป็นผลที่ต้องการ (desired result) ไม่มีประโยคปฏิเสธ
- user *"จริงๆใช้แค่ 1วิ 12 เฟรม"* → Edit ต้องใช้ต้นทาง ≥4 วิ · ตัดใหม่เหลือ 4 วิแรกของคัท 3 (6.042–10.042 ของ V1) → `cut3_4s.mp4` · asset `52029ca5-3d42-4331-9113-6ec235b00107` (แทน `ed030c43` 6 วิ) · ช่วงนี้ยังไม่มีตอนแจ็คปิดประตูรถ → ตัดประโยคตอนปิดประตูออกจากพรอมป์ · contact `EP02/frames/SB02-48_V1_cut3_4s_contact.png` · รอ user ยืนยันว่า 1 วิ 12 เฟรมที่ใช้อยู่ในช่วงนี้ + "ยิง"
- user 2026-10-25 *"ใช่ ยิง"* → `transform_video` edit · seedance-2-5 · 720p · generate_audio true · ต้นทาง `52029ca5` (4 วิ) → ล้ม `reference_registration_failed` 3 รอบ (asset_id ×2 key เดิม · storage_path ×1 key ใหม่) · 0 พอยต์ทุกรอบ · ไฟล์ที่อัปเองลงทะเบียนเป็น virtual asset ฝั่ง provider ไม่ผ่าน · หยุดรอ user เลือกทาง

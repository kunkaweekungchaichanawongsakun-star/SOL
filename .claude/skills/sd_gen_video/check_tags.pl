#!/usr/bin/perl
# A17 — ทุกแท็กจีนในตัวพร้อมป์ ต้องมีแถวในตาราง "แท็กจีน" ที่ช่อง "ที่มา" ไม่ว่าง
# ที่มาที่ยอมรับ: บท / คำ user (ยกมาตรงๆ) / Gemini / สกิล
# ทำไม — 10 ก.ย. 2026 ผมแต่งแท็กเอง 5 อัน (tall and slim · 姿态放得很低 · 给自己看这一眼 · 越骑越自在 · 往里收)
# user ถาม "เอามาจากไหน ใครบอกแกวะ" — ไฟล์นี้ถามแทน ทุกบรรทัด ก่อนยิง
use strict; use warnings; use utf8;
use open qw(:std :utf8);

my $f = shift or die "ใช้: check_tags.pl <prompt.md>\n";
open my $fh, '<:encoding(UTF-8)', $f or die "เปิดไม่ได้: $f\n";
my @lines = <$fh>; close $fh;

# แยก body (ก่อน --- แรก) กับส่วนท้าย
my (@body, @tail); my $in_tail = 0;
for (@lines) { if (!$in_tail && /^---\s*$/) { $in_tail = 1; next } $in_tail ? push @tail, $_ : push @body, $_ }

sub chunks {
  my ($s) = @_;
  my @out;
  for my $p (split /\.\s*/, $s) {
    next unless $p =~ /\p{Han}/;
    $p =~ s/^[^\p{Han}]*//;   # ตัดหัวที่ไม่ใช่จีน
    $p =~ s/\s+$//; $p =~ s/^\s+//;
    push @out, $p if length $p;
  }
  return @out;
}

# ตารางแท็ก: แถวที่ขึ้นต้น | ` และมี ≥3 ช่อง
my %allowed; my %nosrc;
for (@tail) {
  next unless /^\|\s*`/;
  my @c = split /\|/;                     # c[0]='' c[1]=แท็ก c[2]=แปล c[3]=ที่มา
  next if @c < 4;
  (my $tag = $c[1]) =~ s/`//g;
  my $src = $c[3] // ''; $src =~ s/^\s+|\s+$//g;
  for my $ch (chunks($tag)) { $src ne '' ? $allowed{$ch} = $src : $nosrc{$ch} = 1 }
}

my @bad;
for my $ln (@body) {
  for my $ch (chunks($ln)) {
    next if $allowed{$ch};
    push @bad, $nosrc{$ch} ? "  [ไม่มีที่มา] $ch" : "  [ไม่มีในตาราง] $ch";
  }
}

if (@bad) {
  print "── A17 แท็กจีนที่ไม่มีที่มา — ห้ามแต่งเอง ต้องเป็น บท / คำ user / Gemini / สกิล เท่านั้น\n";
  print "$_\n" for @bad; print "\n";
  exit 1;
}
exit 0;

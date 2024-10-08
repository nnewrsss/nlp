#!/bin/bash

set -e  # หยุดการทำงานหากมีข้อผิดพลาด

# ตรวจสอบว่ามีโฟลเดอร์ dataset อยู่แล้วหรือไม่
if [ ! -d "dataset" ]; then
    # ตรวจสอบว่ามีไฟล์ CSV อยู่ในโฟลเดอร์ปัจจุบันหรือไม่
    CSV_FILE="prachathai-67k.csv"
    if [ -f "$CSV_FILE" ]; then
        echo "กำลังสร้างโฟลเดอร์ dataset..."
        mkdir dataset
        
        # ย้ายไฟล์ CSV ไปยังโฟลเดอร์ dataset
        echo "กำลังย้ายไฟล์ CSV ไปยังโฟลเดอร์ dataset..."
        mv "$CSV_FILE" dataset/
        echo "ไฟล์ CSV ถูกย้ายไปที่โฟลเดอร์ dataset เรียบร้อยแล้ว"
    else
        # ดาวน์โหลด dataset จาก Dropbox
        echo "ไม่พบไฟล์ CSV ในโฟลเดอร์ปัจจุบัน กำลังดาวน์โหลด dataset จาก Dropbox..."
        curl -L -o prachathai-67k.zip "https://www.dropbox.com/s/fsxepdka4l2pr45/prachathai-67k.zip?dl=1"
        
        # สร้างโฟลเดอร์ dataset และแตกไฟล์ zip
        echo "กำลังสร้างโฟลเดอร์ dataset และแตกไฟล์ dataset..."
        unzip -q prachathai-67k.zip -d dataset

        # ลบไฟล์ zip เพื่อลดพื้นที่
        rm prachathai-67k.zip
    fi
else
    echo "พบโฟลเดอร์ dataset แล้ว ข้ามขั้นตอนการดาวน์โหลดหรือย้ายไฟล์ CSV"
fi

# ตรวจสอบว่ามีโฟลเดอร์ library อยู่แล้วหรือไม่
if [ ! -d "prachathai-67k" ]; then
    # โคลน library จาก GitHub
    echo "กำลังโคลน library..."
    git clone https://github.com/PyThaiNLP/prachathai-67k.git
else
    echo "พบโฟลเดอร์ prachathai-67k แล้ว ข้ามขั้นตอนการโคลน"
fi

echo "การติดตั้งเสร็จสมบูรณ์"
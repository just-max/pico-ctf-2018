from math import *
import time

image_bytes = open("img.bmp", "rb").read()


with open(time.strftime("output_%H_%M_%S.txt", time.localtime()), "wb") as output:
    lsbits = [byte & 0b1 for byte in image_bytes][:800]

    BYTE_SIZE = 8

    for offset in range(8):
        new_bytes = bytearray(ceil(len(lsbits) / BYTE_SIZE))  # [0] * ceil(len(lsbits) / BYTE_SIZE)

        for bit_i in range(len(lsbits) - offset):
            bit = lsbits[bit_i + offset]
            #print(bit)

            byte_index = floor(bit_i / BYTE_SIZE)
            bit_offset = bit_i - byte_index * BYTE_SIZE
            print(f"Writing a {bit} in byte {byte_index}:{bit_offset}")

            if bit:
                new_bytes[byte_index] = new_bytes[byte_index] | (2 ** (BYTE_SIZE - 1) >> bit_offset)

        output.write(new_bytes)
        output.write(b"\r\n\r\n")

puts("TEST ONE =================")

#failblock1 = ("\0" * 16) + ("\0" * 16)
failblock1 = ("\0" * 16) + ("\0" * (16 - 1)) + "\x01"

shell_st = "echo 5468697320697320616e204956343536" + failblock1.unpack("H*").pop + " | nc 2018shell1.picoctf.com 27533"

result = `#{shell_st}`
puts(result)

#failblock2 = ("\0" * @blocksize) + ("\0" * (@blocksize - 1)) + "\x01"



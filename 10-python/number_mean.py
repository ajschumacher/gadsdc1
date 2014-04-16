counter = 0.0
total_so_far = 0
while (counter < 8):
  counter += 1
  try:
    total_so_far = int(raw_input(["Number?"])) + total_so_far
  except:
    total_so_far = int(raw_input(["I said a number jackass!"]))
  print(total_so_far/counter)

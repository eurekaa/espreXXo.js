


# lazy error management.

   # function definitions
   sum = (a, b, _)-> try tot = a + b; _(null, tot) catch e then _(e)
   diff = (a, b, _)-> try tot = a / b; _(null, tot) catch e then _(e)
   sum_then_diff = (a, b, c, _)-> try sum a, b, _(tot); diff tot, c, _(tot); _(null, tot) catch e then _(e)

   # main
   try
      sum_then_diff 1,8, 3, _(tot)
      console.log tot
   catch e then console.error e




# To be used inside reg_shell/interactive_shell
# with exec(open("power_on.py").read())



# station1 and station2: TE1406 sequence, PSU 12 V / 18 A, initialize the YBr3
rig.power_on()

ybr = rig._ybr # set ybr only after power_on() / attach() succeeded



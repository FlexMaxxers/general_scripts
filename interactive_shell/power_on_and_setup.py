# To be used inside reg_shell/interactive_shell
# with exec(open("power_on.py").read())
cd ~/mirandaricardo/interactive_shell
# --- station1 ---
!ping -c1 -W1 192.168.1.110
rig = get_boresight_rig(ybr_power_supply_ip='192.168.1.110',
tx_camera_ip='192.168.3.22', tx_camera_computer_ip='192.168.3.50')
fixture = get_plc()
off = -2.550391
def correction(y): # y = spot centre row read in pylon Viewer
return (1023 - y) / 90 - off

# station1 and station2: TE1406 sequence, PSU 12 V / 18 A, initialize the YBr3
rig.power_on()

ybr = rig._ybr # set ybr only after power_on() / attach() succeeded



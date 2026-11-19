# Testing the boresight phase
# To be used inside reg_shell/interactive_shell
# with exec(open("test_boresight.py").read())

# 1. Nothing may touch the head (station3: check by eye, there's no workcell control)
fixture.disengage_screwdrivers()
fixture.disengage_fpa_rotator()
fixture.disengage_dut_rotator()


# In pylon Viewer, use the full frame (2592 × 2048, no AOI or binning) so coordinates match the tester. Set the
# exposure to 10 ms, as the test does, and run continuous shot.

# Coarse loop. Step until the spot is in the window 374 < y < 1672 (raw y in pylon Viewer):
# Run the following command manually:

# fixture.rotate_dut(8) # repeat; each +8° moves the spot ~720 px down
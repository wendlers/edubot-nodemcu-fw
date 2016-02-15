import esp
import network

class Sta:

	def __init__(self):
		pass

	def connect(self):
		esp.sleep_type(esp.SLEEP_NONE)
		esp.wifi_mode(esp.STA_MODE)
		network.connect("MosEisleySpaceport", "supersonic")


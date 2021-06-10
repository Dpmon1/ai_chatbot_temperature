from typing import Any, Text, Dict, List

from rasa_sdk import Action, Tracker, FormValidationAction
from rasa_sdk.events import SlotSet
from rasa_sdk.executor import CollectingDispatcher

import requests
import urllib.parse
import json

class ActionGetTemperature(Action):
	
	def name(self) -> Text:
		return "action_get_temperature"

	def run(self, 
		dispatcher: CollectingDispatcher,
		tracker: Tracker,
		domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

		location = tracker.get_slot("location")

		url = "https://dpmon-weather-app.herokuapp.com/weather?" + urllib.parse.urlencode({'address': urllib.parse.quote(location)})
		weather_response = requests.get(url)

		temperatureFarenheit = json.loads(weather_response.content)["forecast"]["currently"]["temperature"]

		temperatureCelcius = (temperatureFarenheit - 32) * (5.0/9)

		dispatcher.utter_message(text = f"The temperature at {location} is {temperatureFarenheit}°F / {temperatureCelcius}°C")

		return []

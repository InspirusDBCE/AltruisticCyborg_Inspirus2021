from flask import Flask,render_template,redirect,request
import warnings
warnings.filterwarnings('ignore')
import pyttsx3
import datetime
import random
import speech_recognition as sr 
import wikipedia 
import webbrowser
import os
import sys
import bs4
import requests
import pyglet
import pyaudio
import googletrans
import warnings
from gtts import gTTS
from time import sleep
listener = sr.Recognizer()


app = Flask("__name__")

def speak(audio):
    engine = pyttsx3.init('sapi5')
    voices = engine.getProperty('voices')
    engine.setProperty('voice',voices[0].id)
    engine.say(audio)
    engine.runAndWait()

def wishMe():
    hour = int(datetime.datetime.now().hour)
    if hour >= 0 and hour<12:
        speak("Good Morning")
    elif hour >= 12 and hour<18:
        speak("Good Afternoon")
    else:
        speak("Good Evening")

    speak("Hello sir, this is AGRO at your service. We are online and ready. Opening Translator module..")

def takeCommand():
    r = sr.Recognizer()
    with sr.Microphone() as source:
        print("Listening...")
        r.pause_threshold = 1
        r.energy_threshold = 500
        audio = r.listen(source)

    try:
        #print("Recognizing...")    
        query = r.recognize_google(audio, language='en-in')
        #print(f"User said: {query}\n")
    
    except Exception as e:
        # print(e)    
        print("Pardon me sir, please try again...")  
        return "None"
    return query

#____________________________________________________________________
#def translator:

#_____________________________________________________________________
def takeCommanding(x):
    r = sr.Recognizer()
    with sr.Microphone() as source:
        print("Listening...")
        r.pause_threshold = 1
        r.energy_threshold = 500
        audio = r.listen(source)

    try:
        #print("Recognizing...")    
        query = r.recognize_google(audio, language=x)
        #print(f"User said: {query}\n")
    
    except Exception as e:
        # print(e)    
        print("Pardon me sir, please try again...")  
        return "None"
    return query
#_____________________________________________________________________
def fromwhichLang():
                print('Sir, which language do you want to speak in?')
                speak('Sir, which language do you want to speak in?')
                x=takeCommand().lower()
                dict1= googletrans.LANGCODES
                try:
                     dict1[x] #print(dict1[x])
                except Exception as e:
                     print("Pardon me sir, the language isn't recognised ...")
                     speak("Pardon me sir, the language isn't recognised. Please Try Again.")
                     return "0"
                return x
def towhichLang():
                print('Sir, to which language do you want me to translate it?')
                speak('Sir, to which language do you want me to translate it?')
                b=takeCommand().lower()
                dict1= googletrans.LANGCODES
                try:
                     dict1[b] #print(dict1[x])
                except Exception as e:
                     print("Pardon me sir, the language isn't recognised ...")
                     speak("Pardon me sir, the language isn't recognised. Please Try Again.")
                     return "0"
                return b
def CheckForExit(query):
                         try:
                             from googletrans import Translator
                         except ImportError: 
                             print("No module named 'Translator' found")
                         trans = Translator()
                         t1 = trans.translate(
                             query, dest='en'
                         )
                         #print("In english: "+t1.text)
                         t2=t1.text.lower()
                         if 'exit' in t2 or 'close the app' in t2 or 'close this app' in t2 or 'shut down' in t2 or 'shutdown' in t2 :
                             print('Closing Translator')
                             speak('Closing Translator')
                             speak('Returning the controls back to AGRO')
                             return "0"
                         else:
                             #print("Exit was not in query")
                             return "1"

def translator():
                wishMe() 
                P=str(datetime.datetime.now())
                print(P)
                x="0"
                while(x=="0"):
                     x=fromwhichLang()
                b="0"
                while(b=="0"):
                     b=towhichLang()
                print("From: \t"+x)
                print("To: \t"+b)
                dict1= googletrans.LANGCODES
                try:
                     z=dict1[b] #print(dict1[b])
                except Exception as e:
                     print("Pardon me sir, the language isn't recognised ...")
                     speak("Pardon me sir, the language isn't recognised. Closing Translator. ")
                     exit()
                     #continue

                try:
                    print("Speak in "+x)
                    speak("Speak in "+x)
                    query = takeCommanding(dict1[x])
                    #z=dict1[b]
                    from googletrans import Translator
                except ImportError: 
                    print("No module named 'Translator' found")

                if(CheckForExit(query)=="0"):
                     return "0"
                while('exit' not in query):
                    if 'None' in query:
                        print("Waiting for command..")
                        query = takeCommanding(dict1[x])
                    elif 'what' in query or 'who' in query or 'where' in query or 'how' in query or 'when' in query or 'which' in query or 'will' in query or 'whom' in query or 'whoose' in query or 'why' in query or 'whether' in query or 'did you' in query:
                         out = query + "?"
                         out = out.replace("translate", "")
                         trans = Translator()
                         t = trans.translate(
                             out, dest=z
                         )
                         print(out)
                         #obj = gTTS(text=t, slow=False, lang= 'fr')
                         print(t.text)
                         """tts = gTTS(text=t.text, slow=False, lang=z)
                         filename = 'temp.mp3'
                         tts.save(filename)
                         warnings.filterwarnings("ignore")
                         music = pyglet.media.load(filename, streaming=False)
                         music.play()
                         warnings.filterwarnings("ignore")
                         sleep(music.duration)
                         os.remove(filename)
                         warnings.filterwarnings("ignore")"""
                         query = takeCommanding(dict1[x])
                         if(CheckForExit(query)=="0"):
                             return "0"
                    else:
                         print(query)
                         query = query.replace("translate", "")
                         trans = Translator()
                         t = trans.translate(
                             query, dest=z
                         )
                         #obj = gTTS(text=t, slow=False, lang= 'fr')
                         print(t.text)
                         """tts = gTTS(text=t.text, slow=False, lang=z)
                         filename = 'temp.mp3'
                         tts.save(filename)
                         warnings.filterwarnings("ignore")   
                         music = pyglet.media.load(filename, streaming=False)
                         music.play()
                         warnings.filterwarnings("ignore")
                         sleep(music.duration)
                         os.remove(filename)
                         warnings.filterwarnings("ignore")"""
                         query = takeCommanding(dict1[x])
                         if(CheckForExit(query)=="0"):
                             return "0"



@app.route('/')
def hello():
    return render_template("index.html")

@app.route("/home")
def home():
    return redirect('/')

@app.route('/',methods=['POST', 'GET'])
def submit():
    try:
         x="1"
         while x=="1":
             x=translator()
         return render_template("index.html")
    except Exception as e:
         return render_template("index.html")
        

if __name__ =="__main__":
    app.run()
    #app.run(debug=True)

#C:/Python/Python39/python.exe c:/Python/AGRO-FlaskAPI-Main/flask-agro.py

"""
AGRO APP Demonstration - For E-SanjeevaniOPD Website
Developed by:- Amatya Katyayan
Student
Don Bosco College of Engineering, Goa, India
"""
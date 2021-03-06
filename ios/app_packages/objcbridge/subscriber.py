import threading
import builtins as __builtin__
from functools import partial

def dprint(text):
    __builtin__.original_print(text)

class Subscriber():
    def __new__(cls):
        if not hasattr(cls, 'instance') or not cls.instance:
            cls.instance = super().__new__(cls)
            cls.instance.handlers = {}
        return cls.instance
    
    def subscribe(self, command, handler):
        self.handlers[command] = handler
        dprint('Subscriber assign. handlers: ' + str(self.handlers))

    def performHandler(self, handler):
        try:
            thread = threading.Thread(target=handler)
            thread.start()
        except Exception as e:
            print('invoke handler exeption: ' + str(e))
                    
    def performCommand(self, cmd, object):
        if cmd == 'classAction':
            self.processClassAction(object)
            return
        if cmd in self.handlers:
            handler = self.handlers[cmd]
            self.performHandler(handler)
        else:
            dprint('unknown command: ' + cmd + '; handlers: ' + str(self.handlers))

    def processClassAction(self, object):
        withResult = object["withResult"]
        try:
            handler = self.handlers[object["class"]]
            action = object["action"]
            args = object['args']
            if handler and action:
                def performActionOnHandler(handler, action):
                    action = action.replace(':', '')
                    func = getattr(handler, action)
                    result = None
                    if callable(func):
                        result = func(*args)
                    if withResult == True:
                        self.send({'command':'response','request':object,'result':result})
                        pass
                    pass
                self.performHandler(partial(performActionOnHandler, handler, action))
        except Exception as e:
            dprint('processClassAction exception: ' + str(e) + '; handlers: ' + str(self.handlers) + '; object: ' + str(object))

    def setClassHandler(self, className, action, handler):
        if isinstance(handler, list):
            for h in handler:
                self.handlers[h.__class__.__name__] = h
        else:
            if handler:
                self.handlers[handler.__class__.__name__] = handler

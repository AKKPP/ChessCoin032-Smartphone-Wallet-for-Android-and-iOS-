from decimal import Decimal
from electrum.util import format_satoshis_plain

class CHESSAmountEdit:
    
    def __init__(self, decimal_point, text, is_int = False, parent=None):
        self.decimal_point = decimal_point
        self.text = text
    
    def _base_unit(self):
        p = self.decimal_point()
        if p == 8:
            return 'CHESS'
        if p == 5:
            return 'mCHESS'
        if p == 2:
            return 'μCHESS'
        raise Exception('Unknown base unit')
    
    def get_amount(self):
        try:
            x = Decimal(str(self.text))
        except:
            return None
        p = pow(10, self.decimal_point())
        return int( p * x )
    
    def setText(self, text):
        pass
    
    def setAmount(self, amount):
        if amount is None:
            self.setText(" ") # Space forces repaint in case units changed
        else:
            self.setText(format_satoshis_plain(amount, self.decimal_point()))


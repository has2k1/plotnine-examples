import os
from glob import glob

EXPATH = os.path.dirname(__file__)
EXFILES = {os.path.basename(file) for file in glob(EXPATH+'/*.ipynb')}

del os, glob

__all__ = ['EXFILES', 'EXPATH']

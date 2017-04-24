import os
from glob import glob

NBPATH = os.path.dirname(__file__)
NBFILES = {os.path.basename(file) for file in glob(NBPATH+'/*.ipynb')}

del os, glob

__all__ = ['NBFILES', 'NBPATH']

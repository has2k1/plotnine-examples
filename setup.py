from setuptools import find_packages, setup

__author__ = 'Hassan Kibirige'
__email__ = 'has2k1@gmail.com'
__description__ = "Usage examples for plotnine"
__license__ = 'BSD (3-clause)'
__url__ = 'https://github.com/has2k1/plotnine-examples'
__version__ = '0.0.1'


def check_dependencies():
    """
    Check for system level dependencies
    """
    pass


def get_required_packages():
    """
    Return required packages

    Plus any version tests and warnings
    """
    install_requires = []
    return install_requires


def get_extra_packages():
    """
    Return extra packages

    Plus any version tests and warnings
    """
    extras_require = {}
    return extras_require


def get_package_data():
    """
    Return package data

    For example:

        {'': ['*.txt', '*.rst'],
         'hello': ['*.msg']}

    means:
        - If any package contains *.txt or *.rst files,
          include them
        - And include any *.msg files found in
          the 'hello' package, too:
    """
    notebooks = ['plotnine_examples/notebooks/*.ipynb']
    package_data = {'plotnine_examples': notebooks}
    return package_data


if __name__ == '__main__':
    check_dependencies()

    setup(name='plotnine_examples',
          maintainer=__author__,
          maintainer_email=__email__,
          description=__description__,
          long_description=__doc__,
          license=__license__,
          version=__version__,
          url=__url__,
          install_requires=get_required_packages(),
          extras_require=get_extra_packages(),
          packages=find_packages(),
          package_data=get_package_data(),
          include_package_data=True,
          classifiers=['Intended Audience :: Science/Research',
                       'License :: OSI Approved :: BSD License',
                       'Operating System :: Microsoft :: Windows',
                       'Operating System :: Unix',
                       'Operating System :: MacOS',
                       'Programming Language :: Python :: 2',
                       'Programming Language :: Python :: 3'],
          zip_safe=False)

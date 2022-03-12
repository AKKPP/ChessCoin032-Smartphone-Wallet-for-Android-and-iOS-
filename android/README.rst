Electrum Chesscoin client
=====================================

::

  Licence: MIT Licence
  Author: Thomas Voegtlin
  Language: Python (>= 3.6)
  Homepage: https://chesscoin032.com/



Getting started
===============

Electrum itself is pure Python, and so are most of the required dependencies,
but not everything. The following sections describe how to run from source, but here
is a TL;DR::

    sudo apt-get install libsecp256k1-0
    python3 -m pip install --user .[gui,crypto]


Not pure-python dependencies
----------------------------

If you want to use the Qt interface, install the Qt dependencies::

    sudo apt-get install python3-pyqt5

For elliptic curve operations, `libsecp256k1`_ is a required dependency::

    sudo apt-get install libsecp256k1-0

Alternatively, when running from a cloned repository, a script is provided to build
libsecp256k1 yourself::

    sudo apt-get install automake libtool
    ./contrib/make_libsecp256k1.sh

Due to the need for fast symmetric ciphers, `cryptography`_ is required.
Install from your package manager (or from pip)::

    sudo apt-get install python3-cryptography


If you would like hardware wallet support, see `this`_.

.. _libsecp256k1: https://github.com/bitcoin-core/secp256k1
.. _pycryptodomex: https://github.com/Legrandin/pycryptodome
.. _cryptography: https://github.com/pyca/cryptography
.. _this: https://github.com/spesmilo/electrum-docs/blob/master/hardware-linux.rst


Development version (git clone)
-------------------------------

Check out the code from GitHub::

    git clone git://github.com/AKKPP/ChessCoin032-Smartphone-Wallet-for-Android-and-iOS-.git
    cd ChessCoin032-Smartphone-Wallet-for-Android-and-iOS-
    git submodule update --init

Run install (this should install dependencies)::

    python3 -m pip install --user -e .


Android Build
=================

See :code:`contrib/android/Readme.md`.


Contributing
============

Any help testing the software, reporting or fixing bugs, reviewing pull requests
and recent changes, writing tests, or helping with outstanding issues is very welcome.
Implementing new features, or improving/refactoring the codebase, is of course
also welcome, but to avoid wasted effort, especially for larger changes,
we encourage discussing these on the issue tracker or IRC first.

Besides `GitHub`_, most communication about Electrum development happens on IRC, in the
:code:`#electrum` channel on Libera Chat. The easiest way to participate on IRC is
with the web client, `web.libera.chat`_.


.. _web.libera.chat: https://web.libera.chat/#electrum
.. _GitHub: https://github.com/spesmilo/electrum

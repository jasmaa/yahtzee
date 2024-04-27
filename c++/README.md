# C++

## Getting started

Install Boost if not already:

```
git clone --recursive https://github.com/boostorg/boost.git
```

Copy the absolute path where the Boost repository was cloned. This will be `BOOST_PATH`.

Create `.env` from `sample.env`. Fill in variables.

Build:

```
make
```

Run:

```
# POSIX
./yahtzee

# Windows
./yahtzee.exe
```
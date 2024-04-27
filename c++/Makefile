include .env

build:
	g++ \
		-I ${BOOST_PATH}/libs/typeof/include \
		-I ${BOOST_PATH}/libs/concept_check/include \
		-I ${BOOST_PATH}/libs/fusion/include \
		-I ${BOOST_PATH}/libs/mp11/include \
		-I ${BOOST_PATH}/libs/parameter/include \
		-I ${BOOST_PATH}/libs/preprocessor/include \
		-I ${BOOST_PATH}/libs/mpl/include \
		-I ${BOOST_PATH}/libs/accumulators/include \
		-I ${BOOST_PATH}/libs/random/include \
		-I ${BOOST_PATH}/libs/config/include \
		-I ${BOOST_PATH}/libs/integer/include \
		-I ${BOOST_PATH}/libs/static_assert/include \
		-I ${BOOST_PATH}/libs/utility/include \
		-I ${BOOST_PATH}/libs/core/include \
		-I ${BOOST_PATH}/libs/type_traits/include \
		-I ${BOOST_PATH}/libs/throw_exception/include \
		-I ${BOOST_PATH}/libs/assert/include \
		-o yahtzee \
		yahtzee.cpp

clean:
	rm -rf *.exe
import tensorflow as tf
from model import DoubleNetwork
from data import get_shuffle_batch

if __name__ == "__main__":
    tf.logging.set_verbosity(tf.logging.INFO)
    with DoubleNetwork(*get_shuffle_batch(16)) as dn:
        dn.learn(50000)
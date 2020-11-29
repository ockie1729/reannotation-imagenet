#!/usr/bin/env python3
# coding: utf-8
import argparse
import os

N_IMAGES_EACH_CLUSTER = 10  # クラスターごとの画像枚数


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--img_rootd", type=str, required=True)
    parser.add_argument("--out", type=str, required=True)
    args = parser.parse_args()

    fnames_dict = {}

    class_names = os.listdir(args.img_rootd)
    for class_name in class_names:
        fnames = os.listdir(os.path.join(args.img_rootd, class_name))

        fnames_dict[class_name] = fnames

    with open(args.out, mode="w") as f:
        cluster_no = 0
        n_images = 0

        for class_id, class_name in enumerate(fnames_dict.keys()):
            for fname in fnames_dict[class_name]:
                if n_images % N_IMAGES_EACH_CLUSTER == 0:
                    cluster_no += 1

                url = 'http://xpaperchallenge.org/tmp/{0}/{1}'.format(class_name,
                                                                      fname)
                f.write('{0},{1},{2}\n'.format(class_id+1,
                                             cluster_no,
                                             url))

                n_images += 1


if __name__ == "__main__":
    main()

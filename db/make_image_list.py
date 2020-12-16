#!/usr/bin/env python3
# coding: utf-8
import argparse
import os

HEAD_N_IMAGES_EACH_CLUSTER = [10]*5 + [20]*5  # クラスターごとの画像枚数(冒頭だけ指定)
REST_N_IMAGES_EACH_CLUSTER = 30  # クラスターごとの画像枚数(残り)
MAX_HEAD = len(HEAD_N_IMAGES_EACH_CLUSTER)  # 冒頭の枚数を指定するクラスタ数
OFFSET_CLUSTER_NO_BETWEEN_CLASS = 100  # クラス間のクラスタ番号の差


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
        for class_no, class_name in enumerate(fnames_dict.keys()):
            cluster_no_in_class = 0
            n_images_in_cluster = 0

            for fname in fnames_dict[class_name]:
                if cluster_no_in_class >= MAX_HEAD:
                    if n_images_in_cluster == REST_N_IMAGES_EACH_CLUSTER:
                        cluster_no_in_class += 1
                        n_images_in_cluster = 0
                else:
                    if n_images_in_cluster == HEAD_N_IMAGES_EACH_CLUSTER[cluster_no_in_class]:
                        cluster_no_in_class += 1
                        n_images_in_cluster = 0

                url = 'http://xpaperchallenge.org/tmp/{0}/{1}'.format(class_name,
                                                                      fname)
                cluster_no = cluster_no_in_class + OFFSET_CLUSTER_NO_BETWEEN_CLASS*class_no
                f.write('{0},{1},{2}\n'.format(class_no+1,
                                               cluster_no+1,
                                               url))

                n_images_in_cluster += 1



if __name__ == "__main__":
    main()

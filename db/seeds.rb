ladies = Category.create(name: "レディース")

tops = ladies.children.create(name: "トップス", size_type_id: 1)
jacket_outer = ladies.children.create(name: "ジャケット/アウター", size_type_id: 1)
pants = ladies.children.create(name: "パンツ", size_type_id: 1)

tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"}, {name: "シャツ/ブラウス(半袖/袖なし)"}])
jacket_outer.children.create([{name: "テーラージャケット"}, {name: "ノーカラージャケット"}, {name: "Gジャン/デニムジャケット"}])
pants.children.create([{name: "デニム/ジーンズ"}, {name: "ショートパンツ"}, {name: "カジュアルパンツ"}])


mens = Category.create(name: "メンズ")

tops = mens.children.create(name: "トップス", size_type_id: 1)
jacket_outer = mens.children.create(name: "ジャケット/アウター", size_type_id: 1)
pants = mens.children.create(name: "パンツ", size_type_id: 1)

tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"}, {name: "シャツ"}])
jacket_outer.children.create([{name: "テーラージャケット"}, {name: "ノーカラージャケット"}, {name: "Gジャン/デニムジャケット"}])
pants.children.create([{name: "デニム/ジーンズ"}, {name: " ワークパンツ/カーゴパンツ"}, {name: "スラックス"}])


baby_kids = Category.create(name: "ベビー・キッズ")

baby_girl = baby_kids.children.create(name: "ベビー服(女の子用) ~95cm", size_type_id: 3)
baby_boy = baby_kids.children.create(name: "ベビー服(男の子用) ~95cm", size_type_id: 3)
baby_unisex = baby_kids.children.create(name: "ベビー服(男女兼用) ~95cm", size_type_id: 3)

baby_girl.children.create([{name: "トップス"}, {name: "アウター"}, {name: "パンツ"}])
baby_boy.children.create([{name: "トップス"}, {name: "アウター"}, {name: "パンツ"}])
baby_unisex.children.create([{name: "トップス"}, {name: "アウター"}, {name: "パンツ"}])



chanel = Brand.create(name: "シャネル")
nike = Brand.create(name: "ナイキ")
louis_vuitton = Brand.create(name: "ルイ・ヴィトン")
supreme = Brand.create(name: "シュプリーム")
adidas = Brand.create(name: "アディダス")

SizeType.create!(
  [
    {
      size_type: "洋服",
    },

    {
      size_type: "靴",
    }
  ]
)

Size.create!(
  [
    {
      name: "XXS以下",
      size_type_id: 1,
    },
    {
      name: "XS(SS)",
      size_type_id: 1,
    },
    {
      name: "S",
      size_type_id: 1,
    },
    {
      name: "M",
      size_type_id: 1,
    },
    {
      name: "L",
      size_type_id: 1,
    },
    {
      name: "XL(LL)",
      size_type_id: 1,
    },
    {
      name: "2XL(3L)",
      size_type_id: 1,
    },
    {
      name: "3XL(4L)",
      size_type_id: 1,
    },
    {
      name: "4XL(5L)以上",
      size_type_id: 1,
    },
    {
      name: "FREE SIZE",
      size_type_id: 1,
    },
    {
      name: "20cm以下",
      size_type_id: 2,
    },
    {
      name: "20.5cm",
      size_type_id: 2,
    },
    {
      name: "21cm",
      size_type_id: 2,
    },
    {
      name: "21.5cm",
      size_type_id: 2,
    },
    {
      name: "22cm",
      size_type_id: 2,
    },
    {
      name: "22.5cm",
      size_type_id: 2,
    },
    {
      name: "23cm",
      size_type_id: 2,
    },
    {
      name: "23.5cm",
      size_type_id: 2,
    },
    {
      name: "24cm",
      size_type_id: 2,
    },
    {
      name: "24.5cm",
      size_type_id: 2,
    },
    {
      name: "25cm",
      size_type_id: 2,
    },
    {
      name: "25.5cm",
      size_type_id: 2,
    },
    {
      name: "26cm",
      size_type_id: 2,
    },
    {
      name: "26.5cm",
      size_type_id: 2,
    },
    {
      name: "27cm",
      size_type_id: 2,
    },
    {
      name: "27.5cm以上",
      size_type_id: 2,
    },
  ]
)

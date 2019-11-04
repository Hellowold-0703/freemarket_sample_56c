ladies = Category.create(name: "レディース")

tops = ladies.children.create(name: "トップス")
jacket_outer = ladies.children.create(name: "ジャケット/アウター")
pants = ladies.children.create(name: "パンツ")

tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"}, {name: "シャツ/ブラウス(半袖/袖なし)"}])
jacket_outer.children.create([{name: "テーラージャケット"}, {name: "ノーカラージャケット"}, {name: "Gジャン/デニムジャケット"}])
pants.children.create([{name: "デニム/ジーンズ"}, {name: "ショートパンツ"}, {name: "カジュアルパンツ"}])


mens = Category.create(name: "メンズ")

tops = mens.children.create(name: "トップス")
jacket_outer = mens.children.create(name: "ジャケット/アウター")
pants = mens.children.create(name: "パンツ")

tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"}, {name: "シャツ"}])
jacket_outer.children.create([{name: "テーラージャケット"}, {name: "ノーカラージャケット"}, {name: "Gジャン/デニムジャケット"}])
pants.children.create([{name: "デニム/ジーンズ"}, {name: " ワークパンツ/カーゴパンツ"}, {name: "スラックス"}])


baby_kids = Category.create(name: "ベビー・キッズ")

baby_girl = baby_kids.children.create(name: "ベビー服(女の子用) ~95cm")
baby_boy = baby_kids.children.create(name: "ベビー服(男の子用) ~95cm")
baby_unisex = baby_kids.children.create(name: "ベビー服(男女兼用) ~95cm")

baby_girl.children.create([{name: "トップス"}, {name: "アウター"}, {name: "パンツ"}])
baby_boy.children.create([{name: "トップス"}, {name: "アウター"}, {name: "パンツ"}])
baby_unisex.children.create([{name: "トップス"}, {name: "アウター"}, {name: "パンツ"}])
extends Node

class_name HepbronConvert

#外部スクリプト読み込み
var jpn_hepbrons_script = preload("res://HepbronConvert/JpnHepbrons.gd").new()

# ひらがなとローマ字の組み合わせ
var jpn_hepbrons = jpn_hepbrons_script.jpn_hepbrons

#日本語からローマ字に変換を行うメソッド
# jpn_string : ひらがなの文字列
# current_hepbron : 現在のローマ字
# front_hepbron : 出力後に前方にくっつけるローマ字（検証はしていない）
func JpnToHebprns( jpn_string : String , front_hepbron : String = "") -> Array :
	
	var regex = RegEx.new()
	var result = []
	
	#日本語のすべてを検証した
	if jpn_string == "":
		return [front_hepbron]
	
	for jpn_hepbron_key in jpn_hepbrons.keys() :
		
		#正規表現を検証するオブジェクト
		var reg_ex_match : RegExMatch
		
		#正規表現を指定（jpn_hepbronsのkeyは正規表現）
		regex.compile(jpn_hepbron_key)
		
		#ひらがなの文字列を検索する
		reg_ex_match = regex.search(jpn_string)
		
		#検索結果が存在した
		if reg_ex_match != null:
			
			#新しい日本語を作成
			var new_jpn_string = ""
			#何文字目で一致したかを取得
			var start_id = reg_ex_match.get_end()
			
			# １文字目で一致した場合はstart_idを１進める
			if start_id == 0 :
				start_id = 1
			
			#一致した文字を削除する
			# ex
			# 1.「あいうえお」
			# 2.「あ：a」が一致した
			# 3.「あいうえお」を「いうえお」に変換する（一致した分を削除）
			for i in range(start_id , jpn_string.length() ):
				new_jpn_string += jpn_string[i]
				pass
			
			#すべてのローマ字の組み合わせを再帰的に検証する
			# ex
			# 「おちゃのは」をローマ字で出力する際、
			# 「ちゃ」を構成するローマ字は「tya」「cya」「cha」の３つ存在するため
			# 「おちゃのはっぱ」のローマ字の組み合わせは
			# 「otyanoha」「ocyanoha」「ochanoha」の３つとなるため
			# 「ちゃ」を検証する際にすべてのローマ字を検証する必要がある。
			for hepbron in jpn_hepbrons[jpn_hepbron_key]:
				result.append_array( JpnToHebprns( new_jpn_string ,front_hepbron + hepbron ) )
				pass
			
			pass
		
		pass
	
	return result

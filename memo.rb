require "csv" # CSVファイルを扱うためのライブラリを読み込んでいます

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"

memo_type = gets.to_i # ユーザーの入力値を取得し、数字へ変換しています

# if文を使用して続きを作成していきましょう。
# 「memo_type」の値（1 or 2）によって処理を分岐させていきましょう。

while true
    if memo_type == 1
        puts "新規のメモ作成を選びました"

        puts "ファイル名を入力してください"
        filename = gets.chomp

        puts "メモを入力してください"
        memo = gets.chomp

        CSV.open(filename,"w")do |csv|
          csv << [memo]
        end

        puts "保存しました"
        break

    elsif memo_type == 2
        puts "既存のメモ編集を選びました"

        puts "編集するCSVファイル名を入力してください"
        filename = gets.chomp

        unless File.exist?(filename)
            puts "ファイルが見つかりません: #{filename}"
            puts "1か2を選んでください"
            memo_type = gets.to_i
            next
        end

        memos = []
        CSV.foreach(filename) do|row|
      memos << row[0]
     end

     puts "現在のメモ一覧"
     memos.each_with_index do |m, i|
      puts "#{i + 1}: #{m}"
    end

    puts "編集したい番号を入力してください (1~#{memos.length})"
    index = gets.to_i - 1

    if index <0|| index >= memos.length
        puts "不正な番号です"
        break
     end

    puts "新しいメモ内容を入力してください"
    new_memo = gets.chomp

    memos[index] = new_memo 
    
    CSV.open(filename,"w") do|csv|
      memos.each do |m|
        csv << [m]
      end
    end

    puts "編集して保存しました: #{filename}"
    break

    else 
        puts "1か2を選んでください"
        memo_type = gets.to_i
    end
end

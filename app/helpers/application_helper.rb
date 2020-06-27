module ApplicationHelper

  # ページごとの完全なタイトルを返します。                   # コメント行
  def full_title(page_title = '')                     # メソッド定義とオプション引数
    base_title = "Recipes from Japan"  # 変数への代入
    if page_title.empty?                              # 論理値テスト
      base_title                                      # 暗黙の戻り値
    else
      page_title + " | " + base_title                 # 文字列の結合
    end
  end

  def link_to_add_fields(name, f, association)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
            render("/shared/" + association.to_s.singularize + "_fields", f: builder)
        end
        link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
    end

end

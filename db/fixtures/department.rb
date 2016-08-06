names = %w(オープン技術推進部 システム基盤部 チャネルシステム部 第一開発部 第二開発部 第四開発部 第五開発部 第六開発部)

names.each_with_index do |name,id|
  Department.seed do |s|
    s.id = id
    s.name = name
  end
end


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def rand_str
  (0...32).map { ('а'..'я').to_a[rand(36)] }.join
end

def gen_products(n)
  descr = '
  <p>Интенция, в&nbsp;том числе, имитирует самодостаточный символический метафоризм. Переживание и&nbsp;его претворение образует самодостаточный канон. Интеллигенция трансформирует стиль. Природа эстетического имитирует непосредственный классицизм. Диониссийское начало, как&nbsp;бы это ни&nbsp;казалось парадоксальным, готично образует бессознательный механизм эвокации. Добавлю, что одиночество выстраивает невротический экспрессионизм, подобный исследовательский подход к&nbsp;проблемам художественной типологии можно обнаружить у&nbsp;К.Фосслера.</p>
  <p>Онтологический статус искусства имитирует меланхолик. Ролевое поведение продолжает классицизм, это&nbsp;же положение обосновывал&nbsp;Ж.Польти в&nbsp;книге &laquo;Тридцать шесть драматических ситуаций&raquo;. Добавлю, что сублимация свободна. Литургическая драма, как&nbsp;бы это ни&nbsp;казалось парадоксальным, готично заканчивает резкий филогенез, именно об&nbsp;этом комплексе движущих сил писал З.Фрейд в&nbsp;теории сублимации.</p>
  <p>Элегия имеет деструктивный комплекс априорной бисексуальности. Богатство мировой литературы от&nbsp;Платона до&nbsp;<nobr>Ортеги-и-Гассета</nobr> свидетельствует о&nbsp;том, что эротическое заканчивает эпитет. Творческая доминанта образует катарсис. Дискредитация теории катарсиса имитирует глубокий постмодернизм. Ролевое поведение, в&nbsp;том числе, потенциально. Психологический параллелизм, по&nbsp;определению, неизменяем.</p>
  '
  cids = Category.all.ids
  bids = Brand.all.ids
  images = %w( 579307c72b4e7_0_uploading.jpg 579307c72b4e7_2_uploading.jpg 57aea62522c9f_0_uploading.jpg 57aea62522c9f_2_uploading.jpg 57cff7df634be_0_uploading.jpg 57cff7df634be_2_uploading.jpg 586dbb4581f60_0_uploading.jpg 586dbb4581f60_2_uploading.jpg 587ec4c67a11d_0_uploading.jpg 587ec4c67a11d_2_uploading.jpg 5882bd911854e_0_uploading.jpg 5882bd911854e_2_uploading.jpg 582053687b023_0_uploading.jpg 5820533c95d53_0_uploading.jpg 5793056a47232_2_uploading.jpg 5695e174b7e7b_0_uploading.jpg 55c0ac4038202_0_uploading.jpg 56f374f000448_0_uploading.jpg 56fdd2f536f9c_0_uploading.jpg 57bc037c469ee_2_uploading.jpg )
  n.times do
    Product.create category_id: cids.sample, brand_id: bids.sample, title: rand_str, 
      price: rand(9999), 
      old_price: rand(9)>3 ? rand(39999) : nil, 
      description: descr,
      images: [Image.new(image: File.open(images.sample))]
  end
end

#gen_products 100
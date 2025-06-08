extends Control

var textNumber = 0
var introText = [
		"Halo pemain! Selamat datang di Kopi Simulator!\n\nDi game ini kamu adalah seorang pemuda yang sedang mencoba memulai usaha kopi kecil-kecilan.",
		"Agar usaha kopimu dapat berkembang, kamu mencoba menerapkan konsep [i]Mareketing mix[/i]. Lalu, apa itu [i]Marketing mix[/i]?",
		"[i]Marketing mix[/i] merupakan sekumpulan variabel pemasaran yang dapat dikontrol oleh perusahaan untuk mencapai tujuannya di dalam pasar yang dituju.
			\n[i]Marketing mix[/i] terdiri dari 4 variabel, yaitu:\n- [b][i]Product[/i][/b] (produk)\n- [b][i]Price[/i][/b] (harga)\n- [b][i]Promotion[/i][/b] (promosi)\n- [b][i]Place[/i][/b] (tempat).",
		"[b][i]Product[/i][/b] (Produk)\n\nProduk adalah segala sesuatu yang dapat ditawarkan ke pasar untuk menarik minat, memperoleh, menggunakan, atau mengonsumsi yang bisa memenuhi suatu keinginan atau kebutuhan.
			\nFaktor-faktor yang terkandung dalam produk adalah:\n- Mutu/kualitas\n- Penampilan ([b][i]features[/i][/b])\n- Pilihan yang ada ([b][i]options[/i][/b])\n- Gaya ([b][i]style[/i][/b])\n- Merek ([b][i]brand names[/i][/b])\n- Pengemasan ([b][i]Packaging[/i][/b])\n- Ukuran ([b][i]Size[/i][/b])\n- Jenis ([b][i]product lines[/i][/b])\n- Macam ([b][i]product items[/i][/b])\n- Jaminan ([b][i]warranties[/i][/b])\n- Pelayanan",
		"[b][i]Price[/i][/b] (Harga)
			\nHarga adalah satuan moneter atau ukuran lain (termasuk barang dan jasa) yang digunakan sebagai alat tukar untuk mendapatkan hak kepemilikan atau penggunaan suatu barang atau jasa.",
		"[b][i]Promotion[/i][/b] (Promosi)
			\nPromosi merupakan cara produsen menyampaikan pesan tentang produknya, sehingga konsumen mengenal produk tersebut dan mengetahui manfaatnya untuk menyelesaikan masalah yang mereka hadapi.",
		"[b][i]Place[/i][/b] (Tempat)
			\nTempat merupakan aktivitas suatu organisasi untuk memudahkan produk didapatkan konsumen sasarannya. Unsur ini mencakup keputusan-keputusan terkait proses perjalanan produk dari organisasi hingga sampai ke tangan konsumen.
			\nMasalah-masalah utama biasanya berkaitan dengan penetapan lokasi penyimpanan yang optimal, sistem distribusi, serta sistem pengiriman dan penyebaran produk.",
		"Setelah mengetahui apa itu [b][i]marketing mix[/i][/b], ayo atur keempat variabel [b][i]marketing mix[/i][/b] untuk toko kopimu!"
	]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if textNumber < introText.size():
		$PanelIntroduction/LabelIntroduction.text = introText[textNumber] # Update teks 'labelIntroduction'
	
	# Atur tombol 'buttonNext' dan 'buttonPrev'
	if textNumber == 0:
		$PanelIntroduction/ButtonPrev.text = "Menu Utama"
	else:
		$PanelIntroduction/ButtonPrev.text = "Kembali"
	
	# Ganti teks pada 'ButtonNext' ke "Atur Variabel"
	if textNumber == introText.size() - 1:
		$PanelIntroduction/ButtonNext.text = "Atur Variabel"
	
	# Pindah scene jika sudah semua text ditampilkan
	if textNumber == introText.size():
		get_tree().change_scene_to_file("res://Scenes/MarketingMix.tscn")


# Fungsi untuk berpindah halaman teks
func _on_buttonNext_pressed():
	$PopSfx.play()
	textNumber += 1

func _on_buttonPrev_pressed():
	$PopSfx.play()
	if textNumber != 0:
		textNumber -= 1
	else:
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

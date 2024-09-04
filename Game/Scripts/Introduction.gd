extends Control

var textNumber = 0
var introText = [
		"Halo pemain! Selamat datang di Kopi Simulator!\nDi game ini kamu adalah seorang pemuda yang sedang mencoba memulai usaha kopi kecil-kecilan.",
		"Agar usaha kopimu dapat berkembang, kamu mencoba menerapkan konsep Mareketing Mix. Lalu, apa itu Marketing Mix?",
		"Marketing mix merupakan sekumpulan variabel pemasaran yang dapat dikontrol oleh perusahaan untuk mencapai tujuannya di dalam pasar yang dituju.
			\n\nMarketing mix terdiri dari 4 variabel, yaitu:\n-Product (produk)\n-Price (harga)\n-Promotion (promosi)\n-Place (tempat).",
		"Product (Produk)\n\nProduk adalah segala sesuatu yang dapat ditawarkan ke pasar untuk menarik minat, memperoleh, menggunakan, atau mengonsumsi yang bisa memenuhi suatu keinginan atau kebutuhan.
			\nFaktor-faktor yang terkandung dalam produk adalah mutu/kualitas, penampilan (features), pilihan yang ada (options), gaya (style), merek (brand names), pengemasan (packaging),
			ukuran (size), jenis (product lines), macam (product items), jaminan (warranties), dan pelayanan.",
		"Price (Harga)\n\nHarga adalah satuan moneter atau ukuran lain (termasuk barang dan jasa) yang digunakan sebagai alat tukar
			untuk mendapatkan hak kepemilikan atau penggunaan suatu barang atau jasa.",
		"Promotion (Promosi)\n\nPromosi merupakan cara produsen menyampaikan pesan tentang produknya, sehingga konsumen mengenal produk tersebut
			dan mengetahui manfaatnya untuk menyelesaikan masalah yang mereka hadapi.",
		"Place (Tempat)\n\nTempat merupakan aktivitas suatu organisasi untuk memudahkan produk didapatkan konsumen sasarannya.
			Unsur ini mencakup keputusan-keputusan terkait proses perjalanan produk dari organisasi hingga sampai ke tangan konsumen.
			\nMasalah-masalah utama biasanya berkaitan dengan penetapan lokasi penyimpanan yang optimal, sistem distribusi, serta sistem pengiriman dan penyebaran produk.",
		"Setelah mengetahui apa itu marketing mix, ayo atur keempat variabel marketing mix untuk toko kopimu!"
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

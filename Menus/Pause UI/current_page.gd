extends Label

var maxPage = 4
var currentPage = 0

func show_page():
	text = str(currentPage)+"/"+str(maxPage);
	show();

func _ready():
	show_page();

func _on_button_r_button_up():
	currentPage += 1;
	if currentPage>maxPage:
		currentPage = 0;
	show_page();

func _on_button_l_button_up():
	currentPage -= 1;
	if currentPage<0:
		currentPage = maxPage;
	show_page();

function search_widgets(term){
	$.ajax({
		url: "/widgets/search?term=" + term,
		type: "GET",
		dataType: "script",
		success: function(result){
			console.log("successsssssssssssssss")
      	},
      	error: function(result){
			console.log("errorrrrrrrrrrrr")
      	}
	});
}
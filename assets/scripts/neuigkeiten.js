var socket = io.connect();

const first_panel_vue = new Vue({
    el: "#nachichten",
    data: {
        nachichten: new Array()
    },
    created: function(){
        this.getNews();
    },
    methods: {
        getNews: function(){
            socket.emit('get News', function(news){
                if(news.Art != null){
                    switch(news.Art){
                        case 0:
                            news.Art = "Unfall";
                            break;
                        case 1:
                            news.Art = "Baustelle";
                            break;
                    }
                }
                first_panel_vue.nachichten = news;
            });
        },
    }
})
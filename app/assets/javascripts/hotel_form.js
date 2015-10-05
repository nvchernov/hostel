/**
 * Created by Nikolay on 03.10.2015.
 */
$(function() {

    var HotelFormModel = Backbone.Model.extend({

    });
    window.hotelFormModel = new HotelFormModel({ });

    var HotelIndexForm = Backbone.View.extend({
        model:  hotelFormModel,
        url: 'http://localhost:3000/hotels/index_form',

        $country:   $('#hotel_country_id'),
        $region:    $('#hotel_region_id'),
        $city:      $('#hotel_city_id'),
        $hotels_div:$('#hotels_container_id'),

        initialize: function () {
            this.setElement('#index_hotel');
            this.model.url = this.url;
        },

        events: {
            'change #hotel_country_id': 'country_changed',
            'change #hotel_region_id': 'region_changed',
            'change #hotel_city_id': 'city_changed'
        },

        country_changed: function(){
            this.model.clear();
            if(this.$country.val() !== '-')
                this.model.set('hotel_country_id', this.$country.val());
            this.model.fetch({type:'POST', success:$.proxy(function(){
                this.render_region_tag();
                this.render_city_tag();
                this.render_hotels();
            }, this)});
        },

        region_changed: function(){
            if(this.$region.val() == '-') {
                this.country_changed();
                return;
            }
            this.model.clear();
            this.model.set('hotel_country_id', this.$country.val());
            this.model.set('hotel_region_id', this.$region.val());
            this.model.fetch({type:'POST', success:$.proxy(function(){
                this.render_city_tag();
                this.render_hotels();
            }, this)});
        },

        city_changed:function(){
            this.model.clear();
            this.model.set('hotel_city_id', this.$city.val());
            this.model.fetch({type:'POST', success:$.proxy(function(){
                this.render_hotels();
            }, this)});
        },

        render_region_tag:function(){
            this.$region.html('');
            this.model.get('regions').forEach((function(v,i){
                this.$region.append('<option value="' + v.id + '">' + v.name + '</option>');
            }),this);
        },

        render_city_tag:function(){
            this.$city.html('');
            this.model.get('cities').forEach((function(v,i){
                this.$city.append('<option value="' + v.id + '">' + v.name + '</option>')
            }),this);
        },

        render_hotels:function(){
            this.$hotels_div.html('');

            this.$hotels_div.append('<tr><th>Название</th><th>Действия</th></tr>');
            this.model.get('hotels').forEach((function(v,i){
                var links =
                '<a href="/hotels/' + v.id + '">Показать</a> ' +
                '<a href="/hotels/' + v.id + '/edit">Редактировать</a> ' +
                '<a data-confirm="Вы уверены?" rel="nofollow" data-method="delete" href="/hotels/' + v.id + '">Удалить</a>';
                this.$hotels_div.append('<tr><td>' + v.name + ' </td><td>' + links + '</td></tr>')
            }),this);
        },

        render:function(){
            if(typeof this.model.get('regions') !== 'undefined')
                this.render_region_tag();
            if(this.$city.val() === '-' && typeof this.model.get('cities') !== 'undefined')
                this.render_city_tag();
            this.render_hotels();
        },
        fetch:function(){
            this.model.fetch({type:'POST', success:$.proxy(this.render, this)});
        },

    });

    window.hotelIndexForm = new HotelIndexForm();



});
/**
 * Created by Nikolay on 02.10.2015.
 */

$(function() {
    var SelectFormModel = Backbone.Model.extend({ });
    window.selectFormModel = new SelectFormModel({});

    RegionCityForm = SelectFormModel.extend({});

    var SelectForm = Backbone.View.extend({
        model: selectFormModel,
        region: "#hotel_region_id",
        city: "#hotel_city_id",

        initialize: function () {
            this.setElement($('#new_hotel'));
            if (this.$el.length == 0)
                this.setElement($('[id^=edit_hotel_]'));
            this.model.url = "http://localhost:3000/cities/get_by_region";
            this.$region = $(this.region);
            this.$city = $(this.city);
        },
        events: {
            "change #hotel_region_id": "region_changed"
        },
        region_changed: function () {
            this.model.set('region_id', this.$region.val());
            this.model.set('cities', {});
            this.model.fetch({type: 'POST', success: $.proxy(this.render_select_tag, this)});
        },

        render_select_tag: function(){
            this.$city.html('');
            this.model.get('cities').forEach((function(v,i){
                this.$city.append('<option value="' + v.id + '">' + v.name + '</option>')
            }),this);
        },

        render: function(){

        }
    });
    window.selectForm = new SelectForm();


    

});
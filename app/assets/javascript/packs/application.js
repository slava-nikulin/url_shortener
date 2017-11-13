import 'bootstrap'
import '../../stylesheets/application.scss'
import Vue from 'vue'
import VueResource from 'vue-resource'
var helper = require('./helper.js');
Vue.use(VueResource)

new Vue({
  el: '#main',
  data: {
    routes: {},
    urlData: {
      originalUrl: "",
      shortUrl: "",
      urlPairs: [],
    },
    validation: {
      disablePage: false,
      short_url_valid: true,
      original_url_valid: true,
      isFormValidating: false,
      original_url_errors: "",
      short_url_errors: ""
    },
  },
  methods: {
    // *** urlData.shortUrl input mask behaviour methods
    onShortChange: function(event) {
      if(this.urlData.shortUrl.length < window.location.origin.length + 1){
        this.urlData.shortUrl = this.constructSiteUrl("/");
      }
    },
    onShortFocus: function(event) {
      if(this.urlData.shortUrl.length == 0){
        this.urlData.shortUrl = this.constructSiteUrl("/"); // add origin to urlData.shortUrl
      }
    },
    onShortUnFocus: function(event) {
      if(this.urlData.shortUrl.length == window.location.origin.length + 1){
        this.urlData.shortUrl = ""; // remove origin from urlData.shortUrl if it was not set
      }
    },
    onShortClick: function(event) {
      var input = event.target;
      var caretPos = input.selectionStart;

      if (input.selectionStart < window.location.origin.length + 1)
      {
        helper.setCaretPosition(input, window.location.origin.length + 1)
      }
    },
    onShortKeyDown: function(event) {
      var input = event.target;
      var caretPos = input.selectionStart;

      if (event.keyCode == '37' || event.keyCode == '39') {
        if (input.selectionStart <= window.location.origin.length + 1)
        {
          event.preventDefault()
          helper.setCaretPosition(input, window.location.origin.length + 1)
        }
      }
    },
    // ***
    onUrlPairsubmit: function(event) {
      setTimeout(function(){ event.target.blur(); }, 400);

      this.validation.disablePage = true;
      var shortUrl = this.urlData.shortUrl.replace(this.constructSiteUrl("/"), "") // remove origin from urlData.shortUrl
      this.$http.post(
        this.routes.url_pairs_url, {url_pair: {original_url: this.urlData.originalUrl, short_path: shortUrl}}
      )
      .then(function ({data}) {
        this.validation.disablePage = false;
        if(!data.success){
          this.validation.isFormValidating = true
          for (var property in data.errors) {
            if (data.errors.hasOwnProperty(property)) {
              this.validation[property + "_errors"] = data.errors[property].join(", ");
              this.validation[property + "_valid"] = false
            }
          }
        }
        else{
          this.getUrlPairs();
          this.validation.isFormValidating = false
          this.validation.original_url_valid = true
          this.validation.short_url_valid = true
          this.validation.original_url_errors = ""
          this.validation.short_url_errors = ""
          this.urlData.shortUrl = ""
          this.urlData.originalUrl = ""
        }
      })
    },
    checkInput: function(flag) {
      return this.validation.isFormValidating ? (flag ? "is-valid" : "is-invalid") : "";
    },
    getUrlPairs: function() {
      this.$http.get(this.routes.url_pairs_url).then(function ({data}) {
        this.urlData.urlPairs = data
      })
    },
    constructSiteUrl: function(path) {
      return window.location.origin + path
    },
    constructExternalUrl: function(url) {
      if (!/^(f|ht)tps?:\/\//i.test(url)) {
        url = "http://" + url;
      }
      return url;
    }
  },
  mounted: function () {
    this.routes = window.routes;
    this.getUrlPairs();
  }
})

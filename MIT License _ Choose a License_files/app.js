(function() {
  var Choosealicense, LicenseSuggestion,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Choosealicense = (function() {
    Choosealicense.prototype.selectText = function(element) {
      var range, selection;
      if (document.body.createTextRange) {
        range = document.body.createTextRange();
        range.moveToElementText(element);
        return range.select();
      } else if (window.getSelection) {
        selection = window.getSelection();
        range = document.createRange();
        range.selectNodeContents(element);
        selection.removeAllRanges();
        return selection.addRange(range);
      }
    };

    Choosealicense.prototype.tooltipAttributesMapperByRuleType = {
      permissions: {
        heading: 'Permission',
        color: 'tooltip--permissions'
      },
      conditions: {
        heading: 'Condition',
        color: 'tooltip--conditions'
      },
      limitations: {
        heading: 'Limitation',
        color: 'tooltip--limitations'
      }
    };

    function Choosealicense() {
      this.initTooltips();
      this.initClipboard();
      this.initLicenseSuggestion();
    }

    Choosealicense.prototype.initTooltips = function() {
      var licenseLiElement, ref, results, rule, rules, ruletype, tooltipAttr;
      ref = window.annotations;
      results = [];
      for (ruletype in ref) {
        rules = ref[ruletype];
        results.push((function() {
          var i, len, results1;
          results1 = [];
          for (i = 0, len = rules.length; i < len; i++) {
            rule = rules[i];
            licenseLiElement = $(".license-" + ruletype + " ." + rule["tag"]);
            tooltipAttr = this.tooltipAttributesMapperByRuleType[ruletype];
            licenseLiElement.attr("aria-label", tooltipAttr.heading + ": " + rule.description);
            results1.push(licenseLiElement.addClass("hint--bottom hint--large hint--no-animate " + tooltipAttr.color + " orverride-hint-inline"));
          }
          return results1;
        }).call(this));
      }
      return results;
    };

    Choosealicense.prototype.initClipboard = function() {
      var clip;
      $(".js-clipboard-button").data("clipboard-prompt", $(".js-clipboard-button").text());
      clip = new Clipboard(".js-clipboard-button");
      clip.on("mouseout", this.clipboardMouseout);
      return clip.on("complete", this.clipboardComplete);
    };

    Choosealicense.prototype.clipboardMouseout = function(client, args) {
      return this.textContent = $(this).data("clipboard-prompt");
    };

    Choosealicense.prototype.clipboardComplete = function(client, args) {
      return this.textContent = "Copied!";
    };

    Choosealicense.prototype.initLicenseSuggestion = function() {
      var inputEl, licenseId, statusIndicator;
      inputEl = $("#repository-url");
      licenseId = inputEl.attr("data-license-id");
      statusIndicator = $(".status-indicator");
      return new LicenseSuggestion(inputEl, licenseId, statusIndicator);
    };

    return Choosealicense;

  })();

  LicenseSuggestion = (function() {
    function LicenseSuggestion(inputEl1, licenseId1, statusIndicator1) {
      this.inputEl = inputEl1;
      this.licenseId = licenseId1;
      this.statusIndicator = statusIndicator1;
      this.setStatus = bind(this.setStatus, this);
      this.bindEventHandlers = bind(this.bindEventHandlers, this);
      this.bindEventHandlers();
    }

    LicenseSuggestion.prototype.inputWraper = $('.input-wrapper');

    LicenseSuggestion.prototype.tooltipErrorClasses = 'hint--bottom tooltip--error hint--always';

    LicenseSuggestion.prototype.bindEventHandlers = function() {
      return this.inputEl.on("input", (function(_this) {
        return function(event) {
          return _this.setStatus("");
        };
      })(this)).on("keyup", (function(_this) {
        return function(event) {
          var repositoryFullName;
          if (event.keyCode === 13 && event.target.value) {
            try {
              repositoryFullName = _this.parseUserInput(event.target.value);
            } catch (error) {
              _this.setStatus("Error", "Invalid URL.");
              return;
            }
            _this.setStatus("Fetching");
            return _this.fetchInfoFromGithubAPI(repositoryFullName, function(err, repositoryInfo) {
              var license, licenseUrl;
              if (repositoryInfo == null) {
                repositoryInfo = null;
              }
              if (err) {
                _this.setStatus("Error", err.message);
                return;
              }
              if (repositoryInfo.license) {
                license = repositoryInfo.license;
                return _this.setStatus("Error", _this.repositoryLicense(repositoryFullName, license));
              } else {
                licenseUrl = encodeURIComponent("https://github.com/" + repositoryFullName + "/community/license/new?template=" + _this.licenseId);
                window.location.href = "https://github.com/login?return_to=" + licenseUrl;
                _this.setStatus("");
                return _this.inputEl.val("");
              }
            });
          }
        };
      })(this));
    };

    LicenseSuggestion.prototype.parseUserInput = function(userInput) {
      var _, project, repository, username;
      repository = /https?:\/\/github\.com\/(.*?)\/(.+)(\.git)?$/.exec(userInput);
      _ = repository[0], username = repository[1], project = repository[2];
      project = project.split(/\/|\.git/).filter(function(str) {
        return str;
      }).slice(0, 1).join("");
      return username + '/' + project;
    };

    LicenseSuggestion.prototype.setStatus = function(status, message) {
      var displayTooltip, statusClass;
      if (status == null) {
        status = "";
      }
      if (message == null) {
        message = "";
      }
      statusClass = status.toLowerCase();
      displayTooltip = (function(_this) {
        return function(status, message) {
          _this.inputWraper.attr('aria-label', status + ": " + message);
          return _this.inputWraper.addClass(_this.tooltipErrorClasses);
        };
      })(this);
      switch (status) {
        case "Fetching":
          return this.statusIndicator.removeClass("error " + this.tooltipErrorClasses).addClass(statusClass);
        case "Error":
          this.statusIndicator.removeClass('fetching').addClass(statusClass);
          return displayTooltip(status, message);
        default:
          this.statusIndicator.removeClass('fetching error');
          return this.inputWraper.removeClass(this.tooltipErrorClasses);
      }
    };

    LicenseSuggestion.prototype.fetchInfoFromGithubAPI = function(repositoryFullName, callback) {
      return $.getJSON("https://api.github.com/repos/" + repositoryFullName, function(info) {
        return callback(null, info);
      }).fail(function(e) {
        if (e.status === 404) {
          return callback(new Error("Repository <b>" + repositoryFullName + "</b> not found."));
        } else {
          return callback(new Error("Network error when trying to get information about <b>" + repositoryFullName + "</b>."));
        }
      });
    };

    LicenseSuggestion.prototype.repositoryLicense = function(repositoryFullName, license) {
      var foundLicense;
      foundLicense = window.licenses.find(function(lic) {
        return lic.spdx_id === license.spdx_id;
      });
      if (foundLicense) {
        return "The repository " + repositoryFullName + " is already licensed under the " + foundLicense.title + ".";
      } else {
        return "The repository " + repositoryFullName + " is already licensed.";
      }
    };

    return LicenseSuggestion;

  })();

  $(function() {
    return new Choosealicense();
  });

}).call(this);

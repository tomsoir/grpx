// Generated by CoffeeScript 1.9.2
(function() {
  (function(root, factory) {
    if (typeof exports === 'object') {
      factory(exports, require('jQuery'));
    } else if (typeof define === 'function' && define.amd) {
      define(['exports', 'jQuery'], factory);
    } else {
      factory(window, $);
    }
  })(this, function(exports, $) {
    var $GRPX, Print, UTILS;
    UTILS = {
      _getImageSrc: function(srcImgStr, staticHost) {
        if (String(srcImgStr) === 'no') {
          return staticHost + '/f/1/global/b/b-calculations/noimg.jpeg';
        } else {
          return staticHost + '/r/' + srcImgStr + '/1.jpg';
        }
      },
      _formatPriceMatrix: function(priceArr, selected_condition) {
        var group, groupName, i, j, len, len1, price, result, textsModule;
        textsModule = this.textsModule;
        result = {
          selectedConditionStr: textsModule[selected_condition],
          selectedCondition: selected_condition,
          groupCondition: {},
          selectedConditionGroup: {},
          otherConditionHeads: [],
          otherConditionGroup: []
        };
        for (i = 0, len = priceArr.length; i < len; i++) {
          price = priceArr[i];
          result.groupCondition[price.cond] = {
            'way': {},
            'name': price.cond,
            'title': textsModule[price.cond],
            'selected': String(selected_condition) === String(price.cond) ? true : false
          };
        }
        for (j = 0, len1 = priceArr.length; j < len1; j++) {
          price = priceArr[j];
          result.groupCondition[price.cond].way[price.way] = price.price;
        }
        for (groupName in result.groupCondition) {
          group = result.groupCondition[groupName];
          if (group.selected) {
            result.selectedConditionGroup = group;
          }
        }
        for (groupName in result.groupCondition) {
          group = result.groupCondition[groupName];
          if (!group.selected) {
            result.otherConditionGroup.push(group);
            result.otherConditionHeads.push({
              name: group.name,
              title: group.title
            });
          }
        }
        return result;
      },
      _monthText: function(number) {
        var text;
        switch (String(number)) {
          case '1':
            text = 'Январь';
            break;
          case '2':
            text = 'Февраль';
            break;
          case '3':
            text = 'Март';
            break;
          case '4':
            text = 'Апрель';
            break;
          case '5':
            text = 'Май';
            break;
          case '6':
            text = 'Июнь';
            break;
          case '7':
            text = 'Июль';
            break;
          case '8':
            text = 'Август';
            break;
          case '9':
            text = 'Сентябрь';
            break;
          case '10':
            text = 'Октябрь';
            break;
          case '11':
            text = 'Ноябрь';
            break;
          case '12':
            text = 'Декабрь';
        }
        return text;
      },
      _returnParam: function(param) {
        if (param) {
          return param;
        } else {
          return void 0;
        }
      },
      _getModifyByText: function(mod_name) {
        var aChunk, asArray, asGroup, chunk, i, len, textsModule;
        textsModule = this.textsModule;
        asArray = [];
        aChunk = String(mod_name).split('_');
        for (i = 0, len = aChunk.length; i < len; i++) {
          chunk = aChunk[i];
          asArray.push(textsModule[String(chunk).toLowerCase()] ? textsModule[String(chunk).toLowerCase()] : chunk);
        }
        asGroup = {};
        aChunk = String(mod_name).split('_');
        return {
          'asArray': asArray,
          'asGroup': {
            'body': {
              'title': textsModule['body'],
              'value': textsModule[String(aChunk[0]).toLowerCase()]
            },
            'engine_volume': {
              'title': textsModule['engine_volume'],
              'value': String(aChunk[1]).replace(/^(.*)\(.*\)$/, '$1')
            },
            'power': {
              'title': textsModule['power'],
              'value': String(aChunk[1]).replace(/^.*\((.*)\)$/, '$1')
            },
            'engine_type': {
              'title': textsModule['engine_type'],
              'value': aChunk[2]
            },
            'privod': {
              'title': textsModule['privod'],
              'value': aChunk[3]
            },
            'transmission': {
              'title': textsModule['transmission'],
              'value': aChunk[4]
            }
          }
        };
      },
      _getBrandIconByMark: function(mark, model, staticHost) {
        var brand, i, len, make, ref;
        make = String(mark).toLowerCase().trim().replace(/(.+)\s.*/g, '$1');
        ref = model.brands;
        for (i = 0, len = ref.length; i < len; i++) {
          brand = ref[i];
          if (brand.id === make) {
            model = brand;
          }
        }
        if (model) {
          return staticHost + '/r/' + String(model.uuid).trim() + '/icon_' + String(model.file_name).trim();
        } else {
          return staticHost + '/r/63806594-6C1E-4C56-BC4B-0E911E967BD4/icon_noimg.jpeg';
        }
      },
      textsModule: {
        'appType': {
          '1': 'справочник',
          '2': 'trade-In',
          '3': 'trade-In отправки заявки',
          '4': 'разработка внутри компании'
        },
        'reportType': {
          '1': 'все расчеты и заявки',
          '2': 'партнерская статистика'
        },
        'внедорожник 3 door': 'Внедорожник 3-х дверный',
        'внедорожник 3 door (new)': 'Внедорожник 3-х дверный (обновленный)',
        'внедорожник 5 door': 'Внедорожник 5-и дверный',
        'внедорожник 5 door (new)': 'Внедорожник 5-и дверный (обновленный)',
        'кабриолет': 'Кабриолет',
        'кабриолет (new)': 'Кабриолет (обновленный)',
        'купе': 'Купе',
        'купе (new)': 'Купе (обновленный)',
        'минивэн': 'Минивэн',
        'минивэн (new)': 'Минивэн (обновленный)',
        'пикап': 'Пикап',
        'пикап (new)': 'Пикап (обновленный)',
        'родстер': 'Родстер',
        'родстер (new)': 'Родстер (обновленный)',
        'седан': 'Седан',
        'седан (new)': 'Седан (обновленный)',
        'универсал': 'Универсал',
        'универсал (new)': 'Универсал (обновленный)',
        'хэтчбек 3 door': 'Хэтчбек 3-х дверный',
        'хэтчбек 3 door (new)': 'Хэтчбек 3-х дверный (обновленный)',
        'хэтчбек 5 door': 'Хэтчбек 5-и дверный',
        'хэтчбек 5 door (new)': 'Хэтчбек 5-и дверный (обновленный)',
        'userGuidText': 'Мы сохраняем 10 последних сделанных вами расчетов.',
        'headerSubText': 'Возможности вашего личного кабинета могут быть увеличены.',
        'yes': 'Да',
        'no': 'Нет',
        'normal': 'Нормальное',
        'good': 'Хорошее',
        'excellent': 'Превосходное',
        'owners': 'Владелец',
        'color': 'Цвет кузова',
        'ckeys': 'Количество ключей',
        'condition': 'Состояние автомобиля',
        'genuine_docs': 'Наличие документов',
        's_color': 'Цвет салона',
        'sbook': 'Наличие сервисной книжки',
        'aerography': 'Аэрография',
        'body': 'Кузов',
        'engine_volume': 'Объем двигателя',
        'power': 'Мощность',
        'engine_type': 'Тип двигателя',
        'privod': 'Привод',
        'transmission': 'Коробка передач'
      }
    };
    Print = (function() {
      Print.prototype.minimalOptions = ['year', 'mid', 'cmid', 'agemonths', 'grp0', 'grp1', 'grp2', 'grp3', 'grp4', 'grp5', 'grp6', 'grp7', 'mileage', 'version'];

      Print.prototype.model = {
        details: void 0,
        price: void 0,
        brands: void 0
      };

      function Print(GRPX, options) {
        this.GRPX = GRPX;
        this.staticHost = GRPX.config.staticHost;
        this.options = options;
      }

      Print.prototype.getData = function() {
        var result;
        result = $.Deferred();
        if (this._checkOptions(result)) {
          this.GRPX._onload(arguments, (function(_this) {
            return function() {
              return _this._getRequireData().done(function() {
                return result.resolve(_this._prepareResultData());
              });
            };
          })(this));
        }
        return result;
      };

      Print.prototype._getRequireData = function() {
        var check, state;
        state = $.Deferred();
        check = (function(_this) {
          return function() {
            if (_this.model.details && _this.model.price && _this.model.brands) {
              return state.resolve();
            }
          };
        })(this);
        if (!this.model.details) {
          this._sendRequest('get_full_details').done((function(_this) {
            return function(data) {
              _this.model.details = data[0];
              return check();
            };
          })(this));
        }
        if (!this.model.price) {
          this._sendRequest('get_calculation').done((function(_this) {
            return function(data) {
              _this.model.price = data;
              return check();
            };
          })(this));
        }
        if (!this.model.brands) {
          this._sendRequest('get_brands').done((function(_this) {
            return function(data) {
              _this.model.brands = data;
              return check();
            };
          })(this));
        }
        check();
        return state;
      };

      Print.prototype._sendRequest = function(name) {
        var params;
        switch (name) {
          case 'get_full_details':
            params = ['year=' + this.options.year, 'mid=' + this.options.mid, 'cmid=' + this.options.cmid, 'version=' + this.options.version];
            return this.GRPX.createRequest('get_full_details', params.join('&') + '&');
          case 'get_calculation':
            params = ['year=' + this.options.year, 'mid=' + this.options.mid, 'cmid=' + this.options.cmid, 'version=' + this.options.version, 'agemonths=' + this.options.agemonths, 'mileage=' + this.options.mileage, 'grp0=' + this.options.grp0, 'grp1=' + this.options.grp1, 'grp2=' + this.options.grp2, 'grp3=' + this.options.grp3, 'grp4=' + this.options.grp4, 'grp5=' + this.options.grp5, 'grp6=' + this.options.grp6, 'grp7=' + this.options.grp7, 'country=' + (this.options.country ? this.options.country : 'RU'), 'province=' + (this.options.province ? this.options.province : '47')];
            return this.GRPX.createRequest('get_calculation', params.join('&') + '&');
          case 'get_brands':
            return this.GRPX.createRequest('get_brands');
        }
      };

      Print.prototype._checkOptions = function(result) {
        var i, len, param, ref, state;
        state = false;
        if (this.options) {
          ref = this.minimalOptions;
          for (i = 0, len = ref.length; i < len; i++) {
            param = ref[i];
            if (typeof this.options[param] === 'undefined') {
              state = false;
            }
          }
          state = true;
        }
        if (!state) {
          console.error('minimal options missing: ' + this.minimalOptions.join(', '));
          result.reject();
        }
        return state;
      };

      Print.prototype._prepareResultData = function() {
        var galleryPath;
        galleryPath = this.model.details.gallery != null ? this.model.details.gallery : 'no';
        return {
          'image': UTILS._getImageSrc(galleryPath, this.staticHost),
          'price': UTILS._formatPriceMatrix(this.model.price.price, this.model.price.selected_condition),
          'date': {
            'yearProduction': this.options.year,
            'yearRegistration': this.options.year,
            'monthRegistration': 1,
            'monthRegistrationStr': UTILS._monthText(1)
          },
          'make': this.model.details.make,
          'makeIcon': UTILS._getBrandIconByMark(this.model.details.make, this.model, this.staticHost),
          'model': this.model.details.model,
          'modify': UTILS._getModifyByText(this.model.details.mod_name),
          'compllectation': {
            'base': UTILS._returnParam(this.model.details.compl_base_name),
            'name': UTILS._returnParam(this.model.details.compl_name),
            'full': this.model.details.compl_base_name ? this.model.details.compl_name + ' (' + this.model.details.compl_base_name + ')' : this.model.details.compl_name
          },
          'mileage': this.options.mileage,
          'version': this.options.version,
          'agemonths': this.options.agemonths,
          'gallery': this.model.details.gallery
        };
      };

      return Print;

    })();
    $GRPX = (function() {
      $GRPX.prototype.ready = false;

      $GRPX.prototype.ver = void 0;

      $GRPX.prototype.desc = void 0;

      $GRPX.prototype.sect = void 0;

      $GRPX.prototype.config = {
        staticHost: 'http://correctprice.ru',
        masterApi: 'http://api.correctprice.ru',
        backupApi: 'http://api2.correctprice.ru'
      };

      function $GRPX(options) {
        if (this._jqueryReady()) {
          this.requiresReady();
        }
      }

      $GRPX.prototype._jqueryReady = function() {
        if ($.isReady) {
          return true;
        }
        console.error('jQuery not ready. Placed this call into $(function{ ... })');
        return false;
      };

      $GRPX.prototype.createRequest = function(service, params) {
        var state;
        state = $.Deferred();
        params = params ? params : '';
        $.ajax({
          url: this.config.masterApi + '/' + service + '?' + params + this._getVersion(params) + 'jsoncallback=?',
          timeout: 3000,
          dataType: "json",
          success: (function(_this) {
            return function(data) {
              if (data != null) {
                return state.resolve(data);
              }
            };
          })(this),
          error: (function(_this) {
            return function() {
              if (_this.config.masterApi !== _this.config.backupApi) {
                _this.config.masterApi = _this.config.backupApi;
                return _this.createRequest(service, params);
              } else {
                return console.error('Error plugin Correct Price api service');
              }
            };
          })(this)
        });
        return state;
      };

      $GRPX.prototype.requiresReady = function() {
        this._readyState = $.Deferred();
        this._requestVersion().done((function(_this) {
          return function() {
            var check;
            if (!(_this.desc || _this.sect)) {
              check = function() {
                if (_this.desc && _this.sect) {
                  _this.ready = true;
                  return _this._readyState.resolve();
                }
              };
              _this.createRequest('get_opt_desc').done(function(data) {
                _this.desc = data;
                return check();
              });
              return _this.createRequest('get_opt_sect').done(function(data) {
                _this.sect = data;
                return check();
              });
            } else {
              return _this._readyState.resolve();
            }
          };
        })(this));
        return this._readyState;
      };

      $GRPX.prototype._changeVersionData = function(version) {
        this.ver = version;
        this.desc = void 0;
        this.sect = void 0;
        return this.requiresReady();
      };

      $GRPX.prototype._requestVersion = function() {
        var state;
        state = $.Deferred();
        if (!this.ver) {
          this.createRequest('get_version').done((function(_this) {
            return function(data) {
              _this.ver = data.version;
              return state.resolve();
            };
          })(this));
        } else {
          state.resolve();
        }
        return state;
      };

      $GRPX.prototype._getVersion = function(params) {
        var regexp, result;
        result = '';
        regexp = new RegExp('version', 'g');
        if (this.ver != null) {
          result = 'version=' + this.ver + '&';
          if (params != null) {
            '&' + result;
          } else {
            '?' + result;
          }
        }
        if (params != null) {
          if (regexp.test(params)) {
            result = '';
          }
        }
        return result;
      };

      $GRPX.prototype._onload = function(args, fn) {
        var self, state;
        if (this._jqueryReady()) {
          self = this;
          state = $.Deferred();
          this._readyState.done(function() {
            var result;
            result = fn.apply(self, args);
            return state.resolve(result);
          });
          return state;
        } else {
          return {
            done: function() {
              return false;
            }
          };
        }
      };

      $GRPX.prototype.version = function() {
        return this.ver;
      };

      $GRPX.prototype.pack = function(oParams, version) {
        var argums, result;
        if (version != null) {
          if (version !== this.ver) {
            result = $.Deferred();
            argums = arguments;
            this._changeVersionData(version).done((function(_this) {
              return function() {
                return _this._onload(argums, _this._pack).done(function(data) {
                  return result.resolve(data);
                });
              };
            })(this));
          } else {
            result = this._onload(arguments, this._pack);
          }
        } else {
          result = this._onload(arguments, this._pack);
        }
        return result;
      };

      $GRPX.prototype._pack = function(oParams) {
        var grps, oFinalPackData, opt_desc, opt_sect, returnStr, simplify;
        opt_desc = this.desc;
        opt_sect = this.sect;
        oFinalPackData = {};
        grps = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]];
        $(opt_desc).each(function(ind, el) {
          if (typeof oParams[el.catg] !== "undefined" && oParams[el.catg] === el.name) {
            return grps[el.grp][(el.pos > 31 ? 1 : 0)] += Math.pow(2, (el.pos > 31 ? el.pos - 32 : el.pos));
          }
        });
        simplify = function(str) {
          while (str.length > 1 && str.substr(0, 1) === "0") {
            str = str.substr(1);
          }
          return str;
        };
        $(grps).each(function(ind, el) {
          el[1] = simplify(el[1].toString(16) + ("00000000" + el[0].toString(16)).substr(-8));
          return el[0] = "grp" + ind;
        });
        returnStr = 'grp0=' + grps[0][1] + '&grp1=' + grps[1][1] + '&grp2=' + grps[2][1] + '&grp3=' + grps[3][1] + '&grp4=' + grps[4][1] + '&grp5=' + grps[5][1] + '&grp6=' + grps[6][1] + '&grp7=' + grps[7][1];
        oFinalPackData['url'] = returnStr;
        oFinalPackData['obj'] = {
          'grp0': grps[0][1],
          'grp1': grps[1][1],
          'grp2': grps[2][1],
          'grp3': grps[3][1],
          'grp4': grps[4][1],
          'grp5': grps[5][1],
          'grp6': grps[6][1],
          'grp7': grps[7][1]
        };
        return oFinalPackData;
      };

      $GRPX.prototype.unpack = function(oGRP, version) {
        var argums, result;
        if (version != null) {
          if (version !== this.ver) {
            result = $.Deferred();
            argums = arguments;
            this._changeVersionData(version).done((function(_this) {
              return function() {
                return _this._onload(argums, _this._unpack).done(function(data) {
                  return result.resolve(data);
                });
              };
            })(this));
          } else {
            result = this._onload(arguments, this._unpack);
          }
        } else {
          result = this._onload(arguments, this._unpack);
        }
        return result;
      };

      $GRPX.prototype._unpack = function(oGRP) {
        var allGroupsTitle, compls, currentGroupName, opt_desc, opt_sect, opt_sect_rev;
        opt_desc = this.desc;
        opt_sect = this.sect;
        compls = oGRP;
        opt_sect_rev = {};
        allGroupsTitle = [];
        currentGroupName = '';
        $(opt_sect).each(function(ind, el) {
          var flagExist, i, item, len;
          opt_sect_rev[el.catg] = el.sect;
          if (currentGroupName !== el.sect) {
            currentGroupName = el.sect;
            flagExist = false;
            for (i = 0, len = allGroupsTitle.length; i < len; i++) {
              item = allGroupsTitle[i];
              if (item === currentGroupName) {
                flagExist = true;
              }
            }
            if (!flagExist) {
              return allGroupsTitle.push(currentGroupName);
            }
          }
        });
        $(compls).each(function(ind2, el2) {
          el2.options = {};
          return $(opt_desc).each(function(ind3, el3) {
            var ofs, s, sect;
            s = el2["grp" + el3.grp];
            ofs = Math.ceil(s.length - el3.pos / 4 - 1);
            if (parseInt("0x" + s.substring(ofs, ofs + 1)) & Math.pow(2, el3.pos % 4)) {
              sect = opt_sect_rev[el3.catg];
              if (el2.options[sect] === undefined) {
                el2.options[sect] = {};
              }
              if (el2.options[sect][el3.catg] === undefined) {
                return el2.options[sect][el3.catg] = el3.name;
              } else if (el2.options[sect][el3.catg] instanceof Array) {
                return el2.options[sect][el3.catg].push(el3.name);
              } else {
                return el2.options[sect][el3.catg] = [el2.options[sect][el3.catg], el3.name];
              }
            }
          });
        });
        return compls.options;
      };

      $GRPX.prototype.unpackToDefault = function(oGRP) {
        return this._onload(arguments, this._unpackToDefault);
      };

      $GRPX.prototype._unpackToDefault = function(oGRP) {
        var defaultOpt, groupName, optName, resultOpt;
        resultOpt = {};
        defaultOpt = this._unpack(oGRP);
        for (groupName in defaultOpt) {
          for (optName in defaultOpt[groupName]) {
            resultOpt[optName] = defaultOpt[groupName][optName][0];
          }
        }
        return resultOpt;
      };

      $GRPX.prototype._extendIncomingToDefault = function(defaultUnpackOpts, incomingUnpackOpts) {
        var optName;
        for (optName in incomingUnpackOpts) {
          if (defaultUnpackOpts[optName]) {
            defaultUnpackOpts[optName] = incomingUnpackOpts[optName];
          } else {
            console.error("Can't find param with name: " + optName);
          }
        }
        return defaultUnpackOpts;
      };

      $GRPX.prototype.packWithDefault = function(oIncomingOpt, oGRP) {
        return this._onload(arguments, this._packWithDefault);
      };

      $GRPX.prototype._packWithDefault = function(oIncomingOpt, oGRP) {
        var defaultOpts, grpx, resultOpts;
        defaultOpts = this._unpackToDefault(oGRP);
        resultOpts = this._extendIncomingToDefault(defaultOpts, oIncomingOpt);
        grpx = this._pack(resultOpts);
        return grpx;
      };

      $GRPX.prototype.getFullDetales = function(options) {
        if (this._printClass == null) {
          this._printClass = new Print(this, options);
        }
        return this._printClass.getData();
      };

      return $GRPX;

    })();
    if (!exports.$GRPX) {
      exports.$GRPX = $GRPX;
    }
    return $GRPX;
  });

}).call(this);

'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var chalk = require('chalk');

var WpGruntedThemeGenerator = module.exports = function WpGruntedThemeGenerator(args, options, config) {
    yeoman.generators.Base.apply(this, arguments);

    this.on('end', function() {
        var _that = this;
        if (this.themeNameSpace) {
            process.chdir(this.themeNameSpace + "/grunt/");
            this.installDependencies({
                skipInstall: options['skip-install'],
                bower: false,
                callback: function() {
                    process.chdir("../js/");
                    this.installDependencies({
                        skipInstall: options['skip-install'],
                        npm: false,
                        callback: function() {
                            process.chdir("../SPA/");
                            this.installDependencies({
                                skipInstall: options['skip-install'],
                                npm: false
                            })
                        }.bind(this)
                    });
                }.bind(this)
            });
        }
    });

    this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(WpGruntedThemeGenerator, yeoman.generators.Base);

WpGruntedThemeGenerator.prototype.askFor = function askFor() {
    var cb = this.async();

    console.log("Ajency.in Logo/Name comming soon :P");

    var prompts = [{
        name: 'themeName',
        message: 'Name of the theme you want to create?'
    }, {
        name: 'themeNameSpace',
        message: 'Uniq name-space for the theme (foldername)?',
        default: function(answers) {
            return answers.themeName.replace(/\W/g, '').toLowerCase();
        }
    }, {
        name: 'themeAuthor',
        message: 'Name of the themes author?',
        default: function(answers) {
            return 'Team Ajency';
        }
    }, {
        name: 'themeAuthorURI',
        message: 'Website of the themes authors?',
        default: function(answers) {
            return 'http://ajency.in/team';
        }
    }, {
        name: 'themeURI',
        message: 'Website of the theme?',
        default: function(answers) {
            return 'http://ajency.in/';
        }
    }, {
        type: 'checkbox',
        name: 'themeTags',
        message: 'Theme tags ( more available on wordpress.org )?',
        choices: ['dark', 'light']
    }, {
        name: 'themeDescription',
        message: 'Description of the theme?',
        default: function(answers) {
            return 'This is a description for the ' + answers.themeName + ' theme.';
        }
    }, {
        name: 'phpcsPath',
        message: 'PHP Code Sniffer path?',
        default: "/usr/bin/phpcs"
    }, {
        name: 'phpUnitPath',
        message: 'PHP unit path?',
        default: "/usr/bin/phpunit"
    }, {
        name: 'githubRepo',
        message: 'Github repository path',
        default: ""
    }];

    this.prompt(prompts, function(props) {
        this.themeName = props.themeName;
        this.themeNameSpace = props.themeNameSpace;
        this.themeAuthor = props.themeAuthor;
        this.themeAuthorURI = props.themeAuthorURI;
        this.themeURI = props.themeURI;
        this.themeTags = props.themeTags;
        this.themeTags = props.themeTags;
        this.phpcsPath = props.phpcsPath;
        this.phpUnitPath = props.phpUnitPath;
        this.githubRepo = props.githubRepo;
        this.jshintTag = '<%= jshint.all %>';

        cb();
    }.bind(this));
};

WpGruntedThemeGenerator.prototype.app = function app() {
    var currentDate = new Date()
    this.themeCreated = currentDate.getFullYear() + '-' + (currentDate.getMonth() + 1) + '-' + currentDate.getDate();

    this.directory('theme', this.themeNameSpace);
    this.mkdir(this.themeNameSpace + '/production');
    this.mkdir(this.themeNameSpace + '/css/fonts');
    this.mkdir(this.themeNameSpace + '/js/modules');
    this.mkdir(this.themeNameSpace + '/js/tests/specs');
    this.mkdir(this.themeNameSpace + '/js/tests/helpers');
    this.mkdir(this.themeNameSpace + '/grunt');
    this.mkdir(this.themeNameSpace + '/SPA/tests/specs');
    this.mkdir(this.themeNameSpace + '/SPA/tests/helpers');
    this.mkdir(this.themeNameSpace + '/classes');
    this.mkdir(this.themeNameSpace + '/tests');

    // move grunt config files
    this.template('_Gruntfile.coffee', this.themeNameSpace + '/grunt/Gruntfile.coffee');
    this.template('_package.json', this.themeNameSpace + '/grunt/package.json');
    this.template('_coffeelint.json', this.themeNameSpace + '/grunt/coffeelint.json');
    this.template('_jshintignore', this.themeNameSpace + '/grunt/.jshintignore');
    this.template('_jshintrc', this.themeNameSpace + '/grunt/.jshintrc');

    //move bower
    this.template('_bower.json', this.themeNameSpace + '/js/bower.json');
    this.template('_spa-bower.json', this.themeNameSpace + '/SPA/bower.json');
};

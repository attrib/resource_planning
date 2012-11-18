
md5 = require '../md5.js'

url_pattern = ///
  ^(http://.*/)(.*)$
///

[url] = window.location.href.match(url_pattern)[1..1]

sio = io.connect url

#
# add person
#
$('#person-add').click (event) ->
  event.preventDefault()
  data =
    name: $('#person-name').val()
    password: md5($('#person-password').val())
    fullname: $('#person-full-name').val()
    location: $('input[name=person-location]:checked').val()
    skills: []

  data.skills.push $(skill).val() for skill in $('input[name=person-skill]:checked')

  # validation
  $('#persons-edit .help-inline').remove()
  $('#persons-edit .error').removeClass('error');

  if not data.name
    $('#person-name').after("<span class=\"help-inline\">Username is required</span>").parent().parent().addClass('error');

  if data.password and data.password != md5($('#person-password-2').val())
    $('#person-password-2').after("<span class=\"help-inline\">Password not equal</span>").parent().parent().addClass('error');

  if not data.location
    $('input[name=person-location]:last').parent().after("<span class=\"help-inline\">Username is required</span>").parent().parent().addClass('error');

  if $('#persons-edit .error').size() == 0
    sio.emit 'person-add', data


#
# add project
#
$('#person-add').click (event) ->
  event.preventDefault()
  data =
    name: $('#person-name').val()
    password: md5($('#person-password').val())
    fullname: $('#person-full-name').val()
    location: $('input[name=person-location]:checked').val()
    skills: []

  data.skills.push $(skill).val() for skill in $('input[name=person-skill]:checked')

  # validation
  $('#persons-edit .help-inline').remove()
  $('#persons-edit .error').removeClass('error');

  if not data.name
    $('#person-name').after("<span class=\"help-inline\">Username is required</span>").parent().parent().addClass('error');

  if data.password and data.password != md5($('#person-password-2').val())
    $('#person-password-2').after("<span class=\"help-inline\">Password not equal</span>").parent().parent().addClass('error');

  if not data.location
    $('input[name=person-location]:last').parent().after("<span class=\"help-inline\">Username is required</span>").parent().parent().addClass('error');

  if $('#persons-edit .error').size() == 0
    sio.emit 'person-add', data


#
# sign up
#
$('#login').click () ->
  data =
    name: $('#login-name').val()
    password: md5($('#login-password').val())
  sio.emit 'login', data

#
# Page Switcher
#
$('ul.nav li').click (event) ->
  event.preventDefault()
  id = $('a', this).attr 'href'
  $('section').hide()
  $('ul.nav li').removeClass 'active'
  $(this).addClass 'active'
  $(id).show()
  window.location.hash = id

if not window.location.hash
  $('ul.nav li:first').click()
else
  $("ul.nav li a[href=#{window.location.hash}]").click()

lapis = require "lapis"

import respond_to, json_params from require "lapis.application"

class extends lapis.Application
    @before_filter =>
        u = @req.parsed_url
        if u.path != "/users/login"
            @session.redirect = "#{u.scheme}://#{u.host}#{u.path}"
        if @session.info
            @info = @session.info
            @session.info = nil

    layout: "default"

    @include "githook/githook"
    @include "users/users"
    @include "ksp"
    @include "polls"
    @include "redirects"
    @include "testing"
    @include "misc"
    @include "blog"

    [index: "/"]: =>
        render: true

    "/submit": => redirect_to: @url_for "ksp_submit_crafts"

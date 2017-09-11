var Comment = function () {
  this.bindEvents();
}
Comment.prototype.bindEvents = function() {
  this.messageFormatter();
  this.bindAddGeneralComment();
  this.bindAddCardComment();
  this.bindClearComment();
};

Comment.prototype.messageFormatter = function() {
  var _this = this;
  $('.comment-message').each(function (e) {
   $(this).html(_this.formatMessage($(this).html()));
  })
};

Comment.prototype.formatMessage= function(message) {
    var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig
    var text1 = message.replace(exp, "<a target='_blank' href='$1'>$1</a>")
    var exp2 = /(^|[^\/])(www\.[\S]+(\b|$))/gim
    return text1.replace(exp2, '$1<a target="_blank" href="http://$2">$2</a>').replace(/<strong(.*?)>(.*?)<\/strong>/g, function(match, p1, p2) { return('<span class="comment-mention">@' + p2 + '</span>') });
};

Comment.prototype.bindAddGeneralComment = function() {
  var _this = this;
  $('.add-general-comment').on('click', function () {
    $textarea = $(this).parent().siblings('.comment-textarea')
    var commentMessage = $textarea.val();
    var commentableType = $textarea.data('commentable-type')
    var commentableId = $textarea.data('commentable-id')

    $.ajax({
      url: '/comments/',
      method: 'post',
      dataType: 'JSON',
      data: { comment: { commentable_id: commentableId, commentable_type: commentableType, message: commentMessage } },
      error: function(result) {
        document.setFlash(result.responseText)
      },
      success: function(result) {
        $textarea.text('');
        $li = $('.blueprint-comment li').clone();
        $li.find('.comment-message').html(_this.formatMessage(commentMessage))
        $textarea.parent().siblings('.comment-group').append($li);
        $()
      }
    });
  })
};
Comment.prototype.bindAddCardComment = function() {
  var _this = this;
  $(document).on('click', '.add-card-comment', function () {
    alert("got call");
    $textarea = $(this).parent().siblings('.comment-textarea')
    var commentMessage = $textarea.text();
    var commentableType = $textarea.data('commentable-type')
    var commentableId = $textarea.data('commentable-id')
    $.ajax({
      url: '/comments/',
      method: 'post',
      dataType: 'JSON',
      data: { comment: { commentable_id: commentableId, commentable_type: commentableType, message: commentMessage } },
      error: function(result) {
        document.setFlash(result.responseText)
      },
      success: function(result) {
        $textarea.text('');
        $li = $('.blueprint-comment li').clone();
        $li.find('.comment-message').html(_this.formatMessage(commentMessage))
        $('.comments-page-' + commentableId + ' .comment-group').append($li);
        if (!($('.comments-page-list-'+ commentableId).html()) && $('#page-comments-modal .page .comments-page-' + commentableId).html()) {
          $pageLi = '<li class="comments-page-list-'+ commentableId +'">' + $('#page-comments-modal .page').html() + '</li>'
          $('.general-comments .active-pages-list').append($pageLi);
        };

      }
    });
  })
};
Comment.prototype.bindClearComment = function() {
  $(document).on('click', '.clear-textarea', function () {
    $(this).parent().siblings('.comment-input__input').text('');
  })
};

$(function(){
  alert("hello");
  new Comment();
})

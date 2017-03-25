" Copyright (C) 2013 Simon Carbajal - simoncarbajal@gmail.com

" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License version 3 as
" published by the Free Software Foundation.

" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.

" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>

if exists("b:did_ftplugin")
    finish
endif

augroup matchpairs
	autocmd! CursorMoved,CursorMovedI,WinEnter <buffer> call Highlight_Matching_Pairs()
augroup END

let g:wordsToMatch = [
	\ ['<\!--', '-->'],
	\ ['<%', '%>'],
	\ ['<var', '</var>'],
	\ ['<ul', '</ul>'],
	\ ['<u', '</u>'],
	\ ['<tt', '</tt>'],
	\ ['<tr', '</tr>'],
	\ ['<title', '</title>'],
	\ ['<thead', '</thead>'],
	\ ['<th', '</th>'],
	\ ['<tfoot', '</tfoot>'],
	\ ['<textarea', '</textarea>'],
	\ ['<td', '</td>'],
	\ ['<tbody', '</tbody>'],
	\ ['<table', '</table>'],
	\ ['<sup', '</sup>'],
	\ ['<sub', '</sub>'],
	\ ['<style', '</style>'],
	\ ['<strong', '</strong>'],
	\ ['<strike', '</strike>'],
	\ ['<span', '</span>'],
	\ ['<small', '</small>'],
	\ ['<select', '</select>'],
	\ ['<script', '</script>'],
	\ ['<samp', '</samp>'],
	\ ['<s', '</s>'],
	\ ['<q', '</q>'],
	\ ['<pre', '</pre>'],
	\ ['<param', '</param>'],
	\ ['<p', '</p>'],
	\ ['<option', '</option>'],
	\ ['<optgroup', '</optgroup>'],
	\ ['<ol', '</ol>'],
	\ ['<object', '</object>'],
	\ ['<noscript', '</noscript>'],
	\ ['<noframes', '</noframes>'],
	\ ['<meta', '</meta>'],
	\ ['<menu', '</menu>'],
	\ ['<map', '</map>'],
	\ ['<link', '</link>'],
	\ ['<li', '</li>'],
	\ ['<legend', '</legend>'],
	\ ['<label', '</label>'],
	\ ['<kbd', '</kbd>'],
	\ ['<isindex', '</isindex>'],
	\ ['<ins', '</ins>'],
	\ ['<input', '</input>'],
	\ ['<img', '</img>'],
	\ ['<iframe', '</iframe>'],
	\ ['<i', '</i>'],
	\ ['<html', '</html>'],
	\ ['<hr', '</hr>'],
	\ ['<head', '</head>'],
	\ ['<h6', '</h6>'],
	\ ['<h5', '</h5>'],
	\ ['<h4', '</h4>'],
	\ ['<h3', '</h3>'],
	\ ['<h2', '</h2>'],
	\ ['<h1', '</h1>'],
	\ ['<frameset', '</frameset>'],
	\ ['<frame', '</frame>'],
	\ ['<form', '</form>'],
	\ ['<font', '</font>'],
	\ ['<fieldset', '</fieldset>'],
	\ ['<em', '</em>'],
	\ ['<dt', '</dt>'],
	\ ['<dl', '</dl>'],
	\ ['<div', '</div>'],
	\ ['<dir', '</dir>'],
	\ ['<dfn', '</dfn>'],
	\ ['<del', '</del>'],
	\ ['<dd', '</dd>'],
	\ ['<colgroup', '</colgroup>'],
	\ ['<col', '</col>'],
	\ ['<code', '</code>'],
	\ ['<cite', '</cite>'],
	\ ['<center', '</center>'],
	\ ['<caption', '</caption>'],
	\ ['<button', '</button>'],
	\ ['<br', '</br>'],
	\ ['<body', '</body>'],
	\ ['<blockquote', '</blockquote>'],
	\ ['<big', '</big>'],
	\ ['<bdo', '</bdo>'],
	\ ['<basefont', '</basefont>'],
	\ ['<base', '</base>'],
	\ ['<b', '</b>'],
	\ ['<area', '</area>'],
	\ ['<applet', '</applet>'],
	\ ['<address', '</address>'],
	\ ['<acronym', '</acronym>'],
	\ ['<abbr', '</abbr>'],
	\ ['<a', '</a>']
\ ]

fu! Highlight_Matching_Pairs()
    " Remove any previous match
    if exists('w:tag_hl_on') && w:tag_hl_on
        2match none
        let w:tag_hl_on = 0
    endif

    let [matchIndex, pairsIndex, isBackwardSearch] = GetWordUnderCursor()
    if matchIndex < 0
    	return
    endif

    let [line, column] = SearchForMatchingWord(pairsIndex, isBackwardSearch)
    call HighlightPairs(line, column, matchIndex, pairsIndex, isBackwardSearch)
endfu

fu! GetWordUnderCursor()
    let col = col('.')
    let isBackwardSearch = 0
    let matchIndex = -1
    let pairsIndex = 0

    for words in g:wordsToMatch
    	let isBackwardSearch = 0
    	for word in words
    		let missingChars = 0
    		let wordLen = strlen(word)
    		let start = col('.') - wordLen
    		if start < 0
    			let missingChars = -start
    			let start = 0
    		endif
    		let linePart = strpart(getline('.'), start, 2 * wordLen - 1)
    		let matchIndex = match(linePart, word . '\c')
    		if matchIndex > -1
    			let matchIndex = matchIndex + missingChars
    			break
			endif
    		let isBackwardSearch = isBackwardSearch + 1
		endfor
		if matchIndex > -1
			break
		endif
    	let pairsIndex = pairsIndex + 1
	endfor

    return [matchIndex, pairsIndex, isBackwardSearch]
endfu

fu! SearchForMatchingWord(pairsIndex, isBackwardSearch)
    let starttag = g:wordsToMatch[a:pairsIndex][0]
    let midtag = ''
    let endtag = g:wordsToMatch[a:pairsIndex][1]
    let flags = 'nW'
    if a:isBackwardSearch
    	let flags = flags .'b'
    	" Limit the search to lines visible in the window.
		let stopline = line('w0')
	else
		let stopline = line('w$')
	endif

    let skip = 0
    let timeout = 500

	if v:version >= 702
		return searchpairpos(starttag, midtag, endtag, flags, skip, stopline, timeout)
	else
		return searchpairpos(starttag, midtag, endtag, flags, skip, stopline)
	endif
endfu

fu! HighlightPairs(line, column, wordIndex, pairsIndex, isBackward)
    if a:line == 0 && a:column == 0
        return
    endif

	let word = g:wordsToMatch[a:pairsIndex][a:isBackward]
	let subStrL = strpart(word, 0, strlen(word) - a:wordIndex - 1)
	let subStrR = strpart(word, strlen(word) - a:wordIndex - 1, a:wordIndex + 1)

	" highlight pairs
    exe '2match MatchParen ^' . subStrL . '\%' . line('.') . 'l\%' . col('.') . 'c' . subStrR . '\c\|' .
    	\ '\%' . a:line . 'l\%' . a:column . 'c'. g:wordsToMatch[a:pairsIndex][a:isBackward?0:1] . '\c^'

	let w:tag_hl_on = 1
endfu

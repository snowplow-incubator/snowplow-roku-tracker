sub init()
	m.Poster = m.top.findNode("poster")
	m.Label = m.top.findNode("label")
	m.Label.font.size = "20"
end sub

Sub itemContentChanged()
	m.Poster.uri = m.top.itemContent.HDPosterUrl
	m.Label.text = m.top.itemContent.Title
	updateLayout()
End Sub

Sub updateLayout()
if m.top.height > 0 and m.top.width > 0
	m.Poster.width = m.top.width
	m.Poster.height = m.top.height
	m.Label.translation = [0, m.Poster.height + 30]
	m.Label.width = m.Poster.width
end if
End Sub

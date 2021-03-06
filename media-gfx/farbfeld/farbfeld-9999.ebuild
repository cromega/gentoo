# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3 toolchain-funcs

DESCRIPTION="farbfeld simple image format tools"
HOMEPAGE="http://tools.suckless.org/farbfeld/"
EGIT_REPO_URI="git://git.suckless.org/farbfeld"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""

RDEPEND="
	media-libs/libjpeg-turbo
	media-libs/libpng:*
"
DEPEND="
	${RDEPEND}
"
PATCHES=(
	"${FILESDIR}"/${PN}-3-as-needed.patch
)

src_prepare() {
	default

	sed -i \
		-e '/^CC/d' \
		-e 's|/usr/local|/usr|g' \
		-e 's|^CFLAGS.*|CFLAGS += -std=c99 -pedantic -Wall -Wextra $(INCS) $(CPPFLAGS)|g' \
		-e 's|^LDFLAGS.*|LDFLAGS += $(LIBS)|g' \
		-e 's|{|(|g;s|}|)|g' \
		config.mk || die
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	emake DESTDIR="${D}" install MANPREFIX=/usr/share/man
}

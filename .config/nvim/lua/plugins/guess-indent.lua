return {
	"nmac427/guess-indent.nvim",
	lazy = false, -- Плагин должен работать сразу при старте, как только открылся файл
	opts = {
		auto_cmd = true, -- Автоматически сканировать файлы при открытии
		override_editorconfig = false, -- Если в проекте уже есть .editorconfig, верить ему
	},
}

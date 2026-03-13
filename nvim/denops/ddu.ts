import { BaseConfig, type ConfigArguments } from "@shougo/ddu-vim/config";
import type { Params as FfParams } from "@shougo/ddu-ui-ff";

export class Config extends BaseConfig {
  override config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchGlobal({
      ui: "ff",
      uiParams: {
        ff: {
          startAutoAction: true,
          autoAction: {
            name: "preview",
          },
          filterFloatingPosition: "bottom",
          filterSplitDirection: "floating",
          floatingBorder: "rounded",
          previewSplit: "horizontal",
          previewFloating: true,
          previewFloatingBorder: "rounded",
          previewFloatingTitle: "Preview",
          prompt: "> ",
          split: "floating",
          startFilter: true,
        } as Partial<FfParams>,
      },
      sourceOptions: {
        _: {
          ignoreCase: true,
          converters: ["converter_devicon", "converter_hl_dir"],
          smartCase: true,
        },
        action: {},
        buffer: {},
        command_history: {},
        file_rec: {},
        git_status: {},
        keymap: {},
        manager_plugins: {
          sorters: ["sorter_alpha"],
        },
        lsp_documentSymbol: {
          converters: ["converter_lsp_symbol"],
        },
      },
      sourceParams: {
        manager_logs: {
          levels: 1,
        },
      },
      kindOptions: {
        action: {
          defaultAction: "do",
        },
        file: {
          defaultAction: "open",
        },
        git_status: {
          defaultAction: "open",
        },
        keymap: {
          defaultAction: "type",
        },
        colorscheme: {
          defaultAction: "set",
        },
        lsp: {
          defaultAction: "open",
        },
      },
    });

    return Promise.resolve();
  }
}

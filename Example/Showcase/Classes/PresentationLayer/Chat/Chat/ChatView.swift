import SwiftUI

struct ChatView: View {

    @EnvironmentObject var presenter: ChatPresenter

    var body: some View {
        ZStack {
            ChatScrollView {
                // TODO: Replace id
                ForEach(presenter.messageViewModels, id: \.text) { message in
                    MessageView(message: message)
                }

                Spacer().frame(height: 72)
            }

            VStack {
                Spacer()

                HStack {
                    InputView(title: "Message...", text: $presenter.input) {
                        presenter.didPressSend()
                    }
                    .padding(16.0)
                }
            }
        }
        .task {
            await presenter.setupInitialState()
        }
    }
}

#if DEBUG
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
#endif

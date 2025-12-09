namespace TabbySSH.Models;

public enum ConnectionStatus
{
    Disconnected,
    Connecting,
    Connected,
    Error
}

public enum AutoReconnectMode
{
    None,
    OnDisconnect,
    OnFocus
}


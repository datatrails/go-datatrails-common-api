package assets

import (
        "github.com/datatrails/go-datatrails-common/grpcclient"
)

type ClientOption = grpcclient.ClientOption

type Client struct {
        g      *grpcclient.Client
        Client AssetsClient
}

func NewClient(log Logger, address string, opts ...ClientOption) *Client {
        return &Client{
                g: grpcclient.New(log, "assetsv2", address, opts...),
        }
}

func (c *Client) Open() error {
        if c.Client != nil {
                return nil
        }
        err := c.g.Open()
        if err != nil {
                return err
        }
        c.Client = NewAssetsClient(c.g.Connector())
        return nil
}

func (c *Client) Close() {
        c.g.Close()
}

